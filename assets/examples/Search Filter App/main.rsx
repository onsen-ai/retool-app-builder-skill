<App>
  <Include src="./functions.rsx" />
  <Frame
    id="$main"
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    paddingType="normal"
    sticky={false}
    type="main"
  >
    <Text
      id="pageTitle"
      marginType="normal"
      value="### Product Catalog"
      verticalAlign="center"
    />
    <Button
      id="setupGuideBtn"
      marginType="normal"
      text="Setup Guide"
    >
      <Event
        id="fc3d4e5f"
        event="click"
        method="show"
        params={{}}
        pluginId="setupGuideModal"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <TextInput
      id="searchInput"
      iconBefore="bold/interface-search"
      label=""
      marginType="normal"
      placeholder="Search by name..."
      showClear={true}
    >
      <Event
        id="ab12cd34"
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="300"
        waitType="debounce"
      />
    </TextInput>
    <Select
      id="categoryFilter"
      data="{{ Array.isArray(selectCategories.data) ? selectCategories.data : [{ id: 1, name: 'Beverages' }, { id: 2, name: 'Supplements' }, { id: 3, name: 'Food' }] }}"
      emptyMessage="All categories"
      itemMode="mapped"
      label="Category"
      labelPosition="top"
      labels="{{ item.name }}"
      marginType="normal"
      placeholder="All categories"
      showClear={true}
      showSelectionIndicator={true}
      values="{{ item.id }}"
    >
      <Event
        id="cd34ef56"
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Select
      id="statusFilter"
      emptyMessage="All statuses"
      itemMode="static"
      label="Status"
      labelPosition="top"
      marginType="normal"
      placeholder="All statuses"
      showClear={true}
      showSelectionIndicator={true}
    >
      <Option id="f1a2b" value="active" label="Active" />
      <Option id="f3c4d" value="draft" label="Draft" />
      <Option id="f5e6f" value="archived" label="Archived" />
      <Event
        id="ef56ab78"
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <DateRange
      id="dateRangeFilter"
      label="Updated"
      labelPosition="top"
      marginType="normal"
      showClear={true}
    >
      <Event
        id="ab78cd90"
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </DateRange>
    <Button
      id="resetBtn"
      marginType="normal"
      styleVariant="outline"
      text="Reset"
    >
      <Event
        id="aa11bb22"
        event="click"
        method="clearValue"
        params={{}}
        pluginId="searchInput"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="cc33dd44"
        event="click"
        method="clearValue"
        params={{}}
        pluginId="categoryFilter"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="ee55ff66"
        event="click"
        method="clearValue"
        params={{}}
        pluginId="statusFilter"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="11223344"
        event="click"
        method="clearValue"
        params={{}}
        pluginId="dateRangeFilter"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        id="55667788"
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="100"
        waitType="debounce"
      />
    </Button>
    <Table
      id="resultsTable"
      cellSelection="none"
      data="{{ Array.isArray(selectProducts.data) ? selectProducts.data : [{ id: 1, name: 'Organic Green Tea', description: 'Premium loose leaf', category: 'Beverages', category_name: 'Beverages', price: 12.99, status: 'active', created_at: '2024-01-15', updated_at: '2024-01-15' }, { id: 2, name: 'Vitamin D3 1000IU', description: 'Daily supplement', category: 'Supplements', category_name: 'Supplements', price: 8.49, status: 'active', created_at: '2024-02-20', updated_at: '2024-03-01' }, { id: 3, name: 'Almond Butter', description: 'Smooth, no added sugar', category: 'Food', category_name: 'Food', price: 6.99, status: 'draft', created_at: '2024-03-10', updated_at: '2024-03-10' }] }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      heightType="auto"
      primaryKeyColumnId="c01a1"
      rowHeight="medium"
      searchMode="caseInsensitive"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      templatePageSize={20}
    >
      <Column
        id="c01a1"
        alignment="left"
        editable={false}
        format="string"
        key="id"
        label="ID"
        position="center"
        size={60}
      />
      <Column
        id="c02b2"
        alignment="left"
        format="string"
        key="name"
        label="Name"
        position="center"
        size={200}
      />
      <Column
        id="c03c3"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        key="category_name"
        label="Category"
        position="center"
        size={120}
      />
      <Column
        id="c04d4"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        key="status"
        label="Status"
        position="center"
        size={100}
      />
      <Column
        id="c05e5"
        alignment="right"
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        key="price"
        label="Price"
        position="center"
        size={100}
      />
      <Column
        id="c06f6"
        alignment="left"
        format="datetime"
        key="updated_at"
        label="Updated"
        position="center"
        size={140}
      />
      <ToolbarButton id="tb01" icon="bold/interface-text-formatting-filter-2" label="Filter" type="filter" />
    </Table>
  </Frame>
  <ModalFrame
    id="setupGuideModal"
    hidden={false}
    hideOnEscape={true}
    overlayInteraction="close"
    showOverlay={true}
    size="medium"
  >
    <Header>
      <Text
        id="setupGuideTitle"
        marginType="normal"
        value="## 🚀 Setup Guide"
        verticalAlign="center"
      />
    </Header>
    <Body>
      <Text
        id="setupGuideText"
        marginType="normal"
        value="{{ 'Welcome! This app is loaded with **sample data** so you can click around and explore right away.\n\nWhen you are ready to wire up your real database, follow these steps:\n\n1. 🔌 **Connect your database** — Go to *Resources* in Retool and add your DB\n2. 🔄 **Update queries** — Open each query in the bottom panel and switch the Resource\n3. 📝 **Update table/column names** — Edit the SQL in each query to match your schema\n4. 🧹 **Remove mock data** — In each Table/Select, remove the mock array fallback from the data attribute\n5. 🗑️ **Delete this modal** — Remove this Setup Guide and the setupGuideBtn button\n\n✅ You are all set — happy building!' }}"
        verticalAlign="top"
      />
    </Body>
  </ModalFrame>
</App>
