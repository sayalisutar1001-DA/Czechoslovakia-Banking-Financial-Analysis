# 🏦 Czechoslovakia Banking & Financial Analysis

An end-to-end **Power BI (.pbix)** dashboard built on the classic 
Czechoslovakia bank dataset, covering customer demographics, account activity, 
loan portfolios, and bank performance across regions and time periods.

---

## 🔗 Live & Download Links
📊 Power BI Dashboard :
View Dashbord

https://app.powerbi.com/links/uyPROxmS7m?ctid=32de7501-956c-4a1a-95e0-18df884e193c&pbi_source=linkShare&bookmarkGuid=74eb17d7-0b41-467d-ac5d-fab5b8bec1c0

📥 Download PBIX File (Google Drive):
Download File

https://drive.google.com/drive/folders/1E0xrsotzMrDYgEWJXRyR-37XaMnjvxap?usp=sharing



## 📌 Dashboard Pages

| Page | Description |
|------|-------------|
| **Report** | High-level overview — total accounts by bank, account types, and transaction status |
| **KPI's** | 15+ KPI cards covering balances, transactions, deposits, withdrawals, and card issuances |
| **Clients Profile Across Districts** | Gender distribution (male/female ratio), client count by district, and regional map |
| **Bank Performance Over Year & Months** | Year-wise waterfall chart, monthly transaction trends with year/month slicers |
| **Account Types — Usage & Profitability** | Top 10 banks by balance & transactions; top 5 by deposit/withdrawal percentage |
| **Bank's Loan Portfolio** | Loan amount by card type, year-wise loan table, YoY growth KPI |

---

## 🗄️ Data Model

Built on a **relational star schema** sourced from `bank_database`, including:

- `account` — Account types and card assignments  
- `client` — Client age and profile  
- `card` — Gold, Silver, Diamond card issuances  
- `loan` — Loan amounts, status, payments, YoY growth  
- `transactions` — Transaction amounts and monthly trends  
- `order` — Order-level payment data  
- `district` — District names and regional mapping  
- `banking_kpi` — Pre-aggregated KPI table (TOT_ACCOUNT, TOT_BALANCE, TOT_TXNS, AVG_BALANCE, DEPOSIT_PERC, WITHDRAWAL_PERC, TPA)  
- `demographic_data_kpi` — District-level demographic KPIs (male/female client count, average salary, ratio)  
- `acc_latest_txns_with_balance` — Latest transaction balances  
- `datemaster_loan` — Date dimension for loan time intelligence  

---

## 📊 Key Metrics Tracked

- Total Accounts, Total Balance, Total Transactions
- Deposit % & Withdrawal % per bank
- Male/Female client ratio by district
- Average salary by region
- Loan portfolio: amount, payments, YoY growth, status
- Card distribution: Gold, Silver, Diamond
- Monthly & yearly bank performance trends

---

## 🛠️ Tools & Tech

- **Power BI Desktop** (Version 2026.03, built from Cloud)
- **DAX** for calculated measures and KPIs
- **Power Query** for data transformation
- **Map visual** for geographic district analysis

---

## 📂 File

| File | Size | Description |
|------|------|-------------|
| `Czechoslovakia_Banking_Financial.pbix` | ~29 MB | Main Power BI report file |

---

## 🚀 Getting Started

1. Download and install [Power BI Desktop](https://powerbi.microsoft.com/desktop/)
2. Clone or download this repository
3. Open `Czechoslovakia_Banking_Financial.pbix` in Power BI Desktop
4. Explore and interact with the 6 report pages

---

## 📜 Dataset

Based on the publicly available **Czechoslovakia Bank Financial Dataset** — 
a benchmark dataset widely used for financial analytics and data science projects.


