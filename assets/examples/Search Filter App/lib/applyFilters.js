const filters = [];

if (searchInput.value) {
  filters.push({
    columnId: "c02b2",
    operator: "includes",
    value: searchInput.value
  });
}

if (categoryFilter.value) {
  filters.push({
    columnId: "c03c3",
    operator: "=",
    value: categoryFilter.value
  });
}

if (statusFilter.value) {
  filters.push({
    columnId: "c04d4",
    operator: "=",
    value: statusFilter.value
  });
}

if (dateRangeFilter.value.start) {
  filters.push({
    columnId: "c06f6",
    operator: ">=",
    value: dateRangeFilter.value.start
  });
}

if (dateRangeFilter.value.end) {
  filters.push({
    columnId: "c06f6",
    operator: "<=",
    value: dateRangeFilter.value.end
  });
}

const stack = filters.length > 0
  ? { filters, operator: "and" }
  : { filters: [], operator: "and" };

resultsTable.setFilterStack(stack);
