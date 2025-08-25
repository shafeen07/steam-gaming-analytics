CREATE OR REPLACE VIEW steam_analytics.quality_success_correlation AS
WITH quality_metrics AS (
    SELECT 
        s.name,
        s.app_id,
        st.genres,
        m.metacritic_score,
        s.current_players,
        s.average_playtime_forever,
        s.price_initial/100 as price_usd,
        st.is_free,
        s.positive_reviews / (s.positive_reviews + s.negative_reviews) * 100 as user_review_pct,
        CASE 
            WHEN m.metacritic_score >= 90 THEN 'Excellent (90+)'
            WHEN m.metacritic_score >= 80 THEN 'Good (80-89)'
            WHEN m.metacritic_score >= 70 THEN 'Average (70-79)'
            ELSE 'Below Average (<70)'
        END as quality_tier,
        CASE
    WHEN (s.positive_reviews / (s.positive_reviews + s.negative_reviews) * 100) >= 90 THEN 'Outstanding (90%+)'
    WHEN (s.positive_reviews / (s.positive_reviews + s.negative_reviews) * 100) >= 80 THEN 'Strong (80-89%)'
    WHEN (s.positive_reviews / (s.positive_reviews + s.negative_reviews) * 100) >= 65 THEN 'Moderate (65-79%)'
    ELSE 'Poor (<65%)'
        END as user_quality_tier
    FROM steam_analytics.steamspy_data s
    JOIN steam_analytics.steam_store_data st ON s.app_id = st.app_id
    LEFT JOIN steam_analytics.metacritic_scores m ON s.app_id = m.app_id
    WHERE s.positive_reviews + s.negative_reviews > 0
      AND s.positive_reviews + s.negative_reviews > 0
)
SELECT 
    app_id,
    name,
    genres,
    metacritic_score,
    current_players,
    average_playtime_forever,
    price_usd,
    is_free,
    user_review_pct,
    quality_tier,
    user_quality_tier,
    -- Window functions for ranking within quality tiers
    ROW_NUMBER() OVER (PARTITION BY user_quality_tier ORDER BY current_players DESC) as rank_in_quality_tier,
    NTILE(4) OVER (ORDER BY current_players) as user_player_quartile,
    -- Compare to quality tier averages
    AVG(current_players) OVER (PARTITION BY user_quality_tier) as avg_players_in_tier,
    current_players - AVG(current_players) OVER (PARTITION BY user_quality_tier) as players_vs_tier_avg
FROM quality_metrics
ORDER BY metacritic_score DESC, current_players DESC