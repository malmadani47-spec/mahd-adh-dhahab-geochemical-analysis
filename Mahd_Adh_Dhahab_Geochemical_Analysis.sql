USE mahdgeologydb;

-- =====================================================
-- Mahd Adh Dhahab Geochemical Analysis
-- Data Source: USGS Open-File Report 90-315, Table 2
-- =====================================================

-- 1. View all geochemical samples
SELECT *
FROM mahd_adh_dhahab_geochemical_samples;


-- 2. Gold concentration by sample
SELECT
    Sample_ID,
    Au_ppm
FROM mahd_adh_dhahab_geochemical_samples
ORDER BY Au_ppm DESC;


-- 3. Copper concentration by sample
SELECT
    Sample_ID,
    Cu_ppm
FROM mahd_adh_dhahab_geochemical_samples
ORDER BY Cu_ppm DESC;


-- 4. Silver concentration by sample
SELECT
    Sample_ID,
    Ag_ppm
FROM mahd_adh_dhahab_geochemical_samples
ORDER BY Ag_ppm DESC;


-- 5. Lead and zinc concentration by sample
SELECT
    Sample_ID,
    Pb_ppm,
    Zn_ppm
FROM mahd_adh_dhahab_geochemical_samples
ORDER BY Pb_ppm DESC;


-- 6. Gold classification
SELECT
    Sample_ID,
    Au_ppm,
    CASE
        WHEN Au_ppm >= 0.10 THEN 'Higher Au'
        ELSE 'Lower Au'
    END AS Au_Category
FROM mahd_adh_dhahab_geochemical_samples;


-- 7. Summary statistics
SELECT
    COUNT(*) AS Total_Samples,
    ROUND(AVG(Au_ppm), 3) AS Average_Au,
    MAX(Au_ppm) AS Maximum_Au,
    ROUND(AVG(Ag_ppm), 2) AS Average_Ag,
    ROUND(AVG(Cu_ppm), 2) AS Average_Cu,
    ROUND(AVG(Pb_ppm), 2) AS Average_Pb,
    ROUND(AVG(Zn_ppm), 2) AS Average_Zn
FROM mahd_adh_dhahab_geochemical_samples;


-- 8. Power BI analysis view
CREATE OR REPLACE VIEW geochemical_analysis AS
SELECT
    Sample_ID,
    Au_ppm,
    Ag_ppm,
    Cu_ppm,
    Pb_ppm,
    Zn_ppm,
    Description,
    CASE
        WHEN Au_ppm >= 0.10 THEN 'Higher Au'
        ELSE 'Lower Au'
    END AS Au_Category
FROM mahd_adh_dhahab_geochemical_samples;


-- 9. Category summary view
CREATE OR REPLACE VIEW geochemical_summary AS
SELECT
    Au_Category,
    COUNT(*) AS Number_of_Samples,
    ROUND(AVG(Au_ppm), 3) AS Avg_Au,
    MAX(Au_ppm) AS Max_Au,
    ROUND(AVG(Ag_ppm), 2) AS Avg_Ag,
    ROUND(AVG(Cu_ppm), 2) AS Avg_Cu,
    ROUND(AVG(Pb_ppm), 2) AS Avg_Pb,
    ROUND(AVG(Zn_ppm), 2) AS Avg_Zn
FROM geochemical_analysis
GROUP BY Au_Category;