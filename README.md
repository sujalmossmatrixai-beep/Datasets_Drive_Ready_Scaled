# Scaled Enterprise Benchmark Datasets

A benchmark dataset repository featuring 30 multi-scale enterprise datasets across 10 industry verticals, organized into three scaling tiers for database migration, schema matching, ETL pipelines, and data integration benchmarks.

---

## Repository Structure

```text
Datasets_Drive_Ready_Scaled/
├── Tier_1_20Src_30Tgt/       # 10 Datasets (20 Source Tables x 30 Target Tables)
├── Tier_2_60Src_50Tgt/       # 10 Datasets (60 Source Tables x 50 Target Tables)
├── Tier_3_80Src_100Tgt/      # 10 Datasets (80 Source Tables x 100 Target Tables)
├── .gitignore
└── README.md
```

---

## Dataset Scale Tiers

| Tier | Folder | Source Tables | Target Tables | Datasets | Purpose |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Tier 1** | `Tier_1_20Src_30Tgt` | 20 | 30 | 10 | Lightweight integration & rapid validation testing |
| **Tier 2** | `Tier_2_60Src_50Tgt` | 60 | 50 | 10 | Mid-tier enterprise ETL & schema matching benchmarks |
| **Tier 3** | `Tier_3_80Src_100Tgt` | 80 | 100 | 10 | High-complexity, high-cardinality enterprise migrations |

---

## Industry Domains (10 Datasets per Tier)

Each tier contains 10 domain-specific enterprise datasets:

1. **Dataset 01**: Fintech, Banking, Wealth Management & Risk
2. **Dataset 02**: Healthcare, Clinical Trials, Pharma & Medical IoT
3. **Dataset 03**: Omnichannel Retail, Logistics & Supply Chain
4. **Dataset 04**: Telecom, 5G Infrastructure, IoT & Smart Energy
5. **Dataset 05**: Hospitality, Mobility, Aviation & Fleet Management
6. **Dataset 06**: Digital Media, Gaming, Entertainment & Social
7. **Dataset 07**: Enterprise HR, Cloud SaaS & Judicial/Compliance
8. **Dataset 08**: Real Estate, Urban Property, Utilities & Dealerships
9. **Dataset 09**: Global Trade, Crypto Fintech & Cross-border Logistics
10. **Dataset 10**: Connected Consumer, Life Services & Digital Platforms

---

## Dataset Directory Layout

Within each dataset directory:
- **`Direcct db connect/`**: DDL schemas (`.sql`), source table definitions, and direct DB ingestion assets.
- **`mannual uplode/`**: Raw CSV data files representing individual enterprise tables.
- **`expected_mapping.xlsx`**: Benchmark ground-truth mapping tables between source attributes and target schemas.
- **Documentation**: Associated schema definitions, relationship diagrams, and data dictionary references (`.md` / `.txt`).

---

## Quick Stats

- **Total Datasets**: 30 (10 per tier across 3 tiers)
- **Total Tables / Files**: ~3,850 files (~3,400 CSV tables, 120 Excel mappings, 60 SQL definitions, 180 Markdown documents)
- **Total Uncompressed Size**: ~80.4 MB
