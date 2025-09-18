# Unicorn-Companies-Analysis
Exploratory Data Analysis of Global Unicorn Companies using SQL for cleaning and Tableau for visualization


🦄 Global Unicorn Startup Analysis

Explore the global unicorn ecosystem through data-driven insights on geography, investors, industries, growth, funding, valuation, and exits. This project uses SQL for data transformation and Tableau dashboards for interactive visualizations.

🎯 Project Objective

1. Analyze geographic and city-level unicorn distribution.

2. Examine investor trends, syndicate efficiency, and industry focus.

3. Understand growth, funding efficiency, and valuation patterns.

4. Explore exit trends and performance metrics.

5. Deliver stakeholder-ready insights and actionable recommendations.

📂 Data Sources
Dataset	Description	Format / Link
Unicorn Database	Global unicorns with valuation, industry, country, city, funding, investor, exit info	[https://www.kaggle.com/datasets/deepcontractor/unicorn-companies-dataset]

All processed data is stored in the /data folder.

🛠️ SQL & Data Workflow

1. Data Cleaning: Removed duplicates, handled missing values, standardized names.

2. Transformations:

Split comma-separated investor and industry lists.

Aggregated total funding, average valuation, and efficiency metrics.

Calculated KPIs like Funding Efficiency (Valuation / Total Funding) and Time to Unicorn.

Sample SQL Query:

-- Average valuation and funding efficiency per country
SELECT 
    country,
    COUNT(unicorn_name) AS unicorn_count,
    AVG(valuation_usd) AS avg_valuation,
    AVG(valuation_usd / total_funding_usd) AS avg_funding_efficiency
FROM unicorn_data
GROUP BY country
ORDER BY unicorn_count DESC;

📊 Dashboards Overview & Insights  

🌍 1️⃣ Geographic Insights

Unicorns concentrate in US, China, India, with San Francisco as the top city.

Smaller countries like Bahamas and Luxembourg excel in valuation and funding efficiency.

💼 2️⃣ Investor Insights

Sequoia Capital dominates unicorn investments.

High-investor unicorns raise more capital but may face efficiency loss.

Fintech and AI attract the most investor attention.

🏭 3️⃣ Industry Insights

Internet Software, Fintech, Health sectors produce high-valuation startups with lean funding.

Certain industries maintain high efficiency even without large funding inflows.

📈 4️⃣ Growth & Funding Insights

Unicorns reach status faster (median 6 years) but require larger funding.

Annual valuation growth ~30%, though funding efficiency is lower for recent cohorts.

🏁 5️⃣ Financial Performance Insights

IPOs and acquisitions dominate exit types.

Exits indicate a trade-off between rapid growth and sustainable returns.

💰 6️⃣ Valuation & Efficiency Insights

Outliers drive extremely high valuations in smaller countries.

Funding efficiency is highest in niche markets with fewer unicorns.

Highlights areas for high return relative to capital deployed.

📌 Key KPIs

Unicorn Count by country, city, industry, investor.

Average Valuation and Valuation Growth Rate.

Funding Efficiency (Valuation / Total Funding).

Time to Unicorn (median years to achieve status).

Exit Count and Exit Type Distribution.

💡 Recommendations for Stakeholders

1. Focus on major ecosystems (US, China, India) for scale, but explore niche markets (Bahamas, Luxembourg) for efficiency.

2. Lean syndicates often outperform heavily funded unicorns in capital efficiency.

3. Target industries like Fintech, AI, Internet Software, and Health for high ROI with lower capital.

4. Balance speed vs efficiency in investment strategy for recent unicorn cohorts.

5. Use dashboards for interactive exploration of geography, investor behavior, and industry trends.

🔗 Tableau Dashboards

Access the interactive dashboards here: https://public.tableau.com/app/profile/amrita.mondal/vizzes
🌐 View Dashboards on Tableau Public

🗂️ Project Structure

/Data                               # Processed datasets
/SQL Coding                         # SQL scripts for data transformation
/Tableau Dashboards Preview         # PNG/JPG screenshots of dashboards
/Tableau Dashboards Preview
   ├─ Geographic Insights.png
   ├─ Investor Landscape.png
   ├─ Industry-specific & Portfolio Performance.png
   ├─ Growth over Time.png
   ├─ Finanacial Stages.png
   └─ Valuation & Funding Efficiency.png      
/Report                             # pdf of Analysis & Findings
/README.md                          # Project overview, insights, KPIs, recommendations
/LICENSE

🖼️ Dashboard Previews
Dashboard	                                                       Preview
🌍 Geographic Insights	                https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Geographic%20Insights.png

💼 Investor Insights	                https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Investors%20Landscape.png

🏭 Industry Insights	                https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Industry-specific%20%26%20Portfolio%20Performance.png

📈 Growth & Funding	                    https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Growth%20over%20Time.png

🏁 Financial Performance	            https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Finanacial%20Stages.png

💰 Valuation & Efficiency	            https://github.com/amritamondal-statistics/Unicorn-Companies-Analysis/blob/main/Tableau%20Dashboards%20Preview/Valuation%20%26%20Funding%20Efficiency.png


📝 Conclusion

This project provides a holistic, data-driven view of the global unicorn ecosystem, highlighting patterns across geography, investors, industry, funding, growth, and exits. Stakeholders can leverage these insights to identify high-potential markets, efficient investment strategies, and emerging sector trends, enabling informed and strategic decision-making in unicorn investing.