
-- Query to extract all unique genres from comma-separated genre column
-- This will help us see what genres are available in the dataset
CREATE OR REPLACE VIEW steam_analytics.genre_analysis AS
WITH split_genres AS (
  SELECT 
    app_id,
    name,
    TRIM(genre) as individual_genre
  FROM steam_analytics.game_performance_analysis,
  UNNEST(SPLIT(genres, ',')) as genre
  WHERE genres IS NOT NULL 
    AND genres != ''
)

SELECT 
  individual_genre,
  COUNT(*) as game_count,
  ROUND(AVG(user_review_pct), 1) as avg_user_review,
  ROUND(AVG(gpa.average_playtime_forever / 60), 1) as avg_playtime_hours
FROM steam_analytics.game_performance_analysis gpa
JOIN split_genres sg ON gpa.app_id = sg.app_id join `steam-analytics-portfolio.steam_analytics.quality_success_correlation`qc on sg.app_id = qc.app_id
where gpa.is_free = true or (gpa.is_free=false and gpa.price_usd > 0)
GROUP BY individual_genre
ORDER BY game_count DESC;