;; Asset Manager Verification Contract
;; Validates and manages asset management companies

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_LICENSE (err u103))

;; Data structures
(define-map verified-managers principal {
    company-name: (string-ascii 100),
    license-number: (string-ascii 50),
    verification-date: uint,
    is-active: bool
})

(define-map manager-stats principal {
    total-assets: uint,
    active-contracts: uint,
    reputation-score: uint
})

;; Public functions
(define-public (verify-manager (manager principal) (company-name (string-ascii 100)) (license-number (string-ascii 50)))
    (begin
        (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
        (asserts! (is-none (map-get? verified-managers manager)) ERR_ALREADY_VERIFIED)
        (asserts! (> (len license-number) u0) ERR_INVALID_LICENSE)

        (map-set verified-managers manager {
            company-name: company-name,
            license-number: license-number,
            verification-date: block-height,
            is-active: true
        })

        (map-set manager-stats manager {
            total-assets: u0,
            active-contracts: u0,
            reputation-score: u100
        })

        (ok true)
    )
)

(define-public (deactivate-manager (manager principal))
    (begin
        (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
        (asserts! (is-some (map-get? verified-managers manager)) ERR_NOT_FOUND)

        (map-set verified-managers manager
            (merge (unwrap-panic (map-get? verified-managers manager)) {is-active: false}))

        (ok true)
    )
)

(define-public (update-manager-stats (manager principal) (assets uint) (contracts uint) (score uint))
    (begin
        (asserts! (is-verified-manager manager) ERR_NOT_FOUND)

        (map-set manager-stats manager {
            total-assets: assets,
            active-contracts: contracts,
            reputation-score: score
        })

        (ok true)
    )
)

;; Read-only functions
(define-read-only (is-verified-manager (manager principal))
    (match (map-get? verified-managers manager)
        manager-data (get is-active manager-data)
        false
    )
)

(define-read-only (get-manager-info (manager principal))
    (map-get? verified-managers manager)
)

(define-read-only (get-manager-stats (manager principal))
    (map-get? manager-stats manager)
)
