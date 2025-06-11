;; Summary: A sophisticated DeFi lending protocol built on Stacks Layer 2 that enables
;;          secure STX collateralized borrowing with dynamic risk management and
;;          automated liquidation mechanisms for the Bitcoin ecosystem.
;;
;; Description: BitVault revolutionizes Bitcoin DeFi by providing a trustless lending
;;              infrastructure where users can deposit STX as collateral to borrow
;;              against their holdings. The protocol features adaptive collateral
;;              ratios, real-time position monitoring, and permissionless liquidations
;;              to maintain system stability. Built with enterprise-grade security
;;              and compliance for institutional adoption on Bitcoin's most robust
;;              Layer 2 solution.
;;
;; PROTOCOL CONSTANTS & ERROR HANDLIN

;; Contract Administration
(define-constant CONTRACT-OWNER tx-sender)

;; System Error Codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-COLLATERAL (err u101))
(define-constant ERR-INVALID-AMOUNT (err u102))
(define-constant ERR-LOAN-NOT-FOUND (err u103))
(define-constant ERR-LOAN-ACTIVE (err u104))
(define-constant ERR-INSUFFICIENT-BALANCE (err u105))
(define-constant ERR-LIQUIDATION-FAILED (err u106))
(define-constant ERR-INVALID-PARAMETER (err u107))

;; Risk Management Parameters
(define-constant MAX-COLLATERAL-RATIO u500) ;; Maximum allowed collateral ratio (500%)
(define-constant MIN-COLLATERAL-RATIO u110) ;; Minimum required collateral ratio (110%)
(define-constant MAX-PROTOCOL-FEE u10) ;; Maximum protocol fee (10%)
;; PROTOCOL STATE VARIABLE

;; Core Risk Parameters
(define-data-var minimum-collateral-ratio uint u150) ;; Default: 150% - Conservative lending ratio
(define-data-var liquidation-threshold uint u130) ;; Default: 130% - Liquidation trigger point
(define-data-var protocol-fee uint u1) ;; Default: 1% - Protocol revenue fee

;; Global Protocol Metrics
(define-data-var total-deposits uint u0) ;; Total STX deposited as collateral
(define-data-var total-borrows uint u0) ;; Total STX borrowed from protocol
;; DATA STRUCTURES & MAPPING

;; Individual Loan Records
(define-map loans
  { loan-id: uint }
  {
    borrower: principal,
    collateral-amount: uint,
    borrowed-amount: uint,
    interest-rate: uint,
    start-height: uint,
    last-interest-update: uint,
    active: bool,
  }
)

;; User Portfolio Tracking
(define-map user-positions
  { user: principal }
  {
    total-collateral: uint, ;; Total STX deposited as collateral
    total-borrowed: uint, ;; Total STX borrowed
    loan-count: uint, ;; Number of active loans
  }
)
;; PRIVATE UTILITY FUNCTION

;; Calculate accumulated interest over time
(define-private (calculate-interest
    (principal uint)
    (rate uint)
    (blocks uint)
  )
  (let (
      (interest-per-block (/ (* principal rate) u10000))
      (total-interest (* interest-per-block blocks))
    )
    total-interest
  )
)

;; Calculate health ratio of collateral vs debt
(define-private (get-collateral-ratio
    (collateral uint)
    (debt uint)
  )
  (if (is-eq debt u0)
    u0
    (/ (* collateral u100) debt)
  )
)