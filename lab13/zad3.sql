SELECT * FROM crosstab(
'SELECT CONCAT(Product_category, Product_sub_category)::text, province::text, COUNT(*)::numeric
FROM sample 
group by 1,2 order by 1,2'
) as ct("category" text, 
        "Alberta" numeric, 
        "BritishColumbia" numeric, 
        "Manitoba" numeric, 
        "NewBrunswick" numeric, 
        "Newfoundland" numeric, 
        "NorthwestTerritories" numeric, 
        "NovaScotia" numeric, 
        "Nunavut" numeric, 
        "Ontario" numeric, 
        "PrinceEdwardIsland" numeric, 
        "Quebec" numeric, 
        "Saskachewan" numeric, 
        "Yukon" numeric, 
        "All" numeric
        );