<GlobalFunctions>
  <RESTQuery
    id="fetchSalesData"
    enableTransformer={true}
    query="https://api.example.com/sales/monthly"
    resourceName="REST-WithoutResource"
    transformer="// Transform API response to flat array
// Replace with your actual API response shape
return data"
  />
  <RESTQuery
    id="fetchCategoryData"
    enableTransformer={true}
    query="https://api.example.com/sales/by-category"
    resourceName="REST-WithoutResource"
    transformer="// Transform API response to flat array
return data"
  />
</GlobalFunctions>
