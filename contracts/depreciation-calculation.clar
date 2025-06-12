;; Depreciation Calculation Contract
;; Calculates asset depreciation using various methods

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_INVALID_PARAMETERS (err u401))
(define-constant ERR_ASSET_NOT_FOUND (err u402))
(define-constant ERR_DIVISION_BY_ZERO (err u403))

;; Depreciation data
(define-map asset-depreciation uint {
    asset-id: uint,
    method: (string-ascii 20),
    useful-life: uint,
    salvage-value: uint,
    annual-rate: uint,
    last-calculated: uint
})

(define-map depreciation-history uint (list 20 {
    year: uint,
    depreciation-amount: uint,
    accumulated-depreciation: uint,
    book-value: uint,
    calculation-date: uint
}))

;; Public functions
(define-public (set-depreciation-parameters
    (asset-id uint)
    (method (string-ascii 20))
    (useful-life uint)
    (salvage-value uint))
    (begin
        (asserts! (> useful-life u0) ERR_INVALID_PARAMETERS)

        (map-set asset-depreciation asset-id {
            asset-id: asset-id,
            method: method,
            useful-life: useful-life,
            salvage-value: salvage-value,
            annual-rate: (if (is-eq method "straight-line")
                           (/ u100 useful-life)
                           u0),
            last-calculated: block-height
        })

        (ok true)
    )
)

(define-public (calculate-straight-line-depreciation (asset-id uint) (purchase-value uint))
    (let ((depreciation-data (unwrap! (map-get? asset-depreciation asset-id) ERR_ASSET_NOT_FOUND)))
        (let ((depreciable-amount (- purchase-value (get salvage-value depreciation-data)))
              (useful-life (get useful-life depreciation-data)))
            (begin
                (asserts! (> useful-life u0) ERR_DIVISION_BY_ZERO)
                (ok (/ depreciable-amount useful-life))
            )
        )
    )
)

(define-public (calculate-declining-balance-depreciation
    (asset-id uint)
    (current-book-value uint)
    (rate uint))
    (let ((depreciation-data (unwrap! (map-get? asset-depreciation asset-id) ERR_ASSET_NOT_FOUND)))
        (begin
            (asserts! (<= rate u100) ERR_INVALID_PARAMETERS)
            (ok (/ (* current-book-value rate) u100))
        )
    )
)

(define-public (record-annual-depreciation
    (asset-id uint)
    (year uint)
    (depreciation-amount uint)
    (accumulated-depreciation uint)
    (book-value uint))
    (let ((current-history (default-to (list) (map-get? depreciation-history asset-id))))
        (begin
            (map-set depreciation-history asset-id
                (unwrap-panic (as-max-len?
                    (append current-history {
                        year: year,
                        depreciation-amount: depreciation-amount,
                        accumulated-depreciation: accumulated-depreciation,
                        book-value: book-value,
                        calculation-date: block-height
                    }) u20)))

            (ok true)
        )
    )
)

;; Read-only functions
(define-read-only (get-depreciation-parameters (asset-id uint))
    (map-get? asset-depreciation asset-id)
)

(define-read-only (get-depreciation-history (asset-id uint))
    (map-get? depreciation-history asset-id)
)

(define-read-only (calculate-current-book-value (asset-id uint) (purchase-value uint) (years-elapsed uint))
    (match (map-get? asset-depreciation asset-id)
        depreciation-data
        (let ((annual-depreciation (unwrap-panic (calculate-straight-line-depreciation asset-id purchase-value)))
              (total-depreciation (* annual-depreciation years-elapsed)))
            (if (> total-depreciation (- purchase-value (get salvage-value depreciation-data)))
                (get salvage-value depreciation-data)
                (- purchase-value total-depreciation)))
        u0
    )
)
