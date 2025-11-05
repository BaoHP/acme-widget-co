
# Acme Widget Co — Basket System (Proof of Concept)

## Overview

This is a Ruby proof of concept for a shopping basket system for **Acme Widget Co**.  
The program calculates the total cost of items in a basket, applying **product prices**, **delivery rules**, and **special offers**.

The company sells three products:

| Product       | Code | Price  |
|----------------|------|--------|
| Red Widget     | R01  | $32.95 |
| Green Widget   | G01  | $24.95 |
| Blue Widget    | B01  | $7.95  |

---

## Features

- Calculates basket totals including promotions and delivery charges.
- Applies **delivery charge rules**:
  - Orders **under $50** → $4.95 delivery fee  
  - Orders **under $90** → $2.95 delivery fee  
  - Orders **$90 or more** → free delivery  
- Applies **special offers**:
  - “Buy one Red Widget (R01), get the second half price.”

---

## How to Run

### Requirements
- Ruby version **3.0 or higher** (recommended)
- No external gems required

### Steps

1. Clone the repository:
   ```bash
   git clone git@github.com:BaoHP/acme-widget-co.git
   cd acme-basket

