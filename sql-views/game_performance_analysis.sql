CREATE OR REPLACE VIEW steam_analytics.game_performance_analysis AS
SELECT 
    s.app_id,
    s.name,
    s.owners,
    s.average_playtime_forever,
    s.average_playtime_2weeks,
    s.current_players,
    s.positive_reviews,
    s.negative_reviews,
    ROUND(s.positive_reviews / (s.positive_reviews + s.negative_reviews) * 100, 1) as review_score_pct,
    s.price_initial/100 as price_usd,
    st.is_free,
    st.genres,
    st.developer,
    m.metacritic_score,
CASE 
  WHEN s.price_initial = 0 AND st.is_free = false THEN 'Delisted'
  WHEN s.price_initial = 0 AND st.is_free = true THEN 'Free-to-Play'  
  WHEN s.price_initial <= 1000 THEN 'Budget ($<9.99)'
  WHEN s.price_initial <= 3000 THEN 'Mid-tier ($10-29.99)'
  ELSE 'Premium ($30+)'
END AS pricing_tier,
    CASE 
        WHEN s.current_players > 100000 THEN 'Very High'
        WHEN s.current_players > 10000 THEN 'High'
        WHEN s.current_players > 1000 THEN 'Medium'
        ELSE 'Low'
    END as player_activity_level,
    CASE 
  WHEN owners LIKE '%20,000,000%' THEN 'Mega Hit (20M+)'
  WHEN owners LIKE '%10,000,000%' THEN 'Major Success (10-20M)' 
  WHEN owners LIKE '%5,000,000%' THEN 'Popular (5-10M)'
  WHEN owners LIKE '%2,000,000%' THEN 'Successful (2-5M)'
  WHEN owners LIKE '%1,000,000%' THEN 'Hit (1-2M)'
  WHEN owners LIKE '%500,000%' THEN 'Solid (500K-1M)'
  WHEN owners LIKE '%200,000%' THEN 'Moderate (200K-500K)'
  WHEN owners LIKE '%100,000%' THEN 'Modest (100K-200K)'
  WHEN owners LIKE '%50,000%' THEN 'Small (50K-100K)'
  WHEN owners LIKE '%20,000%' THEN 'Niche (20K-50K)'
  ELSE 'Very Niche (<20K)'
END AS ownership_category
FROM steam_analytics.steamspy_data s
JOIN steam_analytics.steam_store_data st ON s.app_id = st.app_id
LEFT JOIN steam_analytics.metacritic_scores m ON s.app_id = m.app_id
WHERE s.name IS NOT NULL AND s.name != ''