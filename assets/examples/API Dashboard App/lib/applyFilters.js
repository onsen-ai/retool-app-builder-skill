const filters = [];

if (searchInput.value) {
  filters.push({ columnId: "b2c3d", operator: "includes", value: searchInput.value });
}
if (roleFilter.value) {
  filters.push({ columnId: "d4e5f", operator: "=", value: roleFilter.value });
}

const stack = filters.length > 0
  ? { filters, operator: "and" }
  : { filters: [], operator: "and" };

usersTable.setFilterStack(stack);
