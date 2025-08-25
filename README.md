# Steam Gaming Analytics Dashboard

A comprehensive data science project analyzing Steam gaming market dynamics to identify success patterns and performance drivers in the PC gaming industry.

## Project Overview

This analysis examines pricing strategies, player satisfaction, engagement metrics, and genre performance across 91 trending Steam games to understand the multiple pathways to commercial success. The project demonstrates end-to-end data science capabilities from data collection through interactive visualization.

**Interactive Dashboard:** [View Live Dashboard](https://lookerstudio.google.com/s/qEwOBag8Lmg)

## Data Sources

- **SteamSpy API:** Player engagement, ownership, and review metrics
- **Steam Store API:** Pricing, genre, and game metadata  
- **Metacritic Web Scraping:** Professional critic scores for quality assessment

**Dataset:** 91 active Steam games (excluded 9 delisted titles to ensure analysis reflects original pricing strategies)

## Key Findings

### 1. Pricing Strategy Insights
- Identified market gap between $29.99 psychological pricing threshold and $40+ premium pricing
- Lower competition in $30-39 range represents potential market positioning opportunity
- All pricing tiers show similar quality distributions, suggesting pricing flexibility for developers

### 2. Quality vs. Success Dynamics  
- Player satisfaction and lifetime engagement represent distinct success metrics with weak correlation
- Games can achieve 90%+ positive reviews with moderate playtime (quality-focused experiences)
- Others drive high engagement despite lower review scores (retention-focused experiences)

### 3. Genre Performance Patterns
- Free-to-play and MMO games dominate engagement (135+ hours) but show lower satisfaction scores
- Strategy games achieve near-perfect satisfaction (99%) with moderate engagement  
- RPGs and Action games successfully balance both high engagement and strong satisfaction

## Technical Implementation

### SQL Views and Data Pipeline

**Core analytical infrastructure built with BigQuery:**

- **`game_performance_analysis.sql`** - Main dataset combining multiple data sources with business logic for pricing tiers, ownership categories, and player activity levels
- **`quality_success_correlation.sql`** - Advanced analysis using window functions to rank games within quality tiers and compare performance metrics
- **`genre_analysis.sql`** - Genre performance breakdown handling comma-separated values with string manipulation functions

### Key Technical Skills Demonstrated

- **Advanced SQL:** Window functions, CTEs, complex joins, string manipulation (SPLIT, UNNEST)
- **Data Integration:** Multi-source API integration and web scraping
- **Business Logic Implementation:** CASE statements for categorical analysis and tier segmentation
- **Interactive Visualization:** Looker Studio dashboard with dynamic filtering and direct Steam store integration

## Repository Structure

```
steam-gaming-analytics/
├── README.md
├── data-collection/
│   └── steam_data_collection.ipynb
├── sql-views/
│   ├── game_performance_analysis.sql
│   ├── quality_success_correlation.sql
│   └── genre_analysis.sql
├── dashboard-screenshots/
|   |── 01_project_overview.png
│   ├── 02_market_penetration.png
│   ├── 03_competitive_positioning.png
│   ├── 04_player_satisfaction.png
│   ├── 05_genre_performance.png
│   ├── 06_game_explorer.png
|   └── 07_executive_summary.png
└── docs/
    └── dashboard_link.md
```

## Interactive Features

The dashboard includes an interactive **Game Explorer** allowing users to:
- Browse through all 91 analyzed games via dropdown selection
- View comprehensive metrics (playtime, reviews, pricing, genres)
- Access direct links to Steam store pages
- Discover games based on data-driven insights

## Data Limitations and Scope

This analysis is based on a sample of 91 active Steam games and should be interpreted within that scope. Key limitations include:
- Ownership data provided in categories rather than exact figures
- Absence of development cost and revenue information  
- Potential sampling bias toward popular/visible games
- Dataset represents a market snapshot rather than comprehensive industry coverage

## Future Enhancements

Potential areas for expansion:
- Revenue estimates and ROI analysis
- Temporal analysis of game performance over time
- Player retention rate integration
- Seasonal trends and platform-specific performance
- Expanded sample sizes across different market segments

## Technical Stack

- **Data Processing:** Google Cloud Platform, BigQuery
- **Visualization:** Looker Studio
- **Data Collection:** Python (Google Colab)
- **APIs:** SteamSpy, Steam Store
- **Web Scraping:** Metacritic scores

---

*This project showcases advanced SQL techniques, multi-source data integration, and business-focused visualization capabilities for data science portfolio demonstration.*