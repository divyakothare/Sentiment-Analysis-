CREATE VIEW VW_PostSentiment_Scored
AS
SELECT 
    P.post_id,
    U.user_name,
    P.post_text,

    -- Score calculation--
    SUM(
        CASE 
            WHEN SK.sentiment_type = 'Positive' THEN 1
            WHEN SK.sentiment_type = 'Negative' THEN -1
            ELSE 0
        END
    ) AS SentimentScore,

    -- Final sentiment--
    CASE 
        WHEN SUM(
            CASE 
                WHEN SK.sentiment_type = 'Positive' THEN 1
                WHEN SK.sentiment_type = 'Negative' THEN -1
                ELSE 0
            END
        ) > 0 THEN 'Positive'

        WHEN SUM(
            CASE 
                WHEN SK.sentiment_type = 'Positive' THEN 1
                WHEN SK.sentiment_type = 'Negative' THEN -1
                ELSE 0
            END
        ) < 0 THEN 'Negative'

        ELSE 'Neutral'
    END AS FinalSentiment

FROM post P
JOIN users U ON P.user_id = U.user_id
LEFT JOIN sentiment_Keyword SK
ON P.post_text LIKE '%' + SK.Keyword + '%'

GROUP BY P.post_id, U.user_name, P.post_text;

SELECT * FROM VW_PostSentiment_Scored