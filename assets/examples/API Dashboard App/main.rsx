<App>
  <Include src="./functions.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
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
      value="### Users"
      verticalAlign="center"
    />
    <Button
      id="setupGuideBtn"
      marginType="normal"
      text="Setup Guide"
    >
      <Event
        id="fa1b2c3d"
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
      placeholder="Search users..."
      showClear={true}
    >
      <Event
        id="a1b2c3d4"
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
    <Select
      id="roleFilter"
      emptyMessage="No options"
      itemMode="static"
      label=""
      marginType="normal"
      placeholder="Filter by role..."
      showClear={true}
      showSelectionIndicator={true}
    >
      <Option id="f1a1a" value="admin" label="Admin" />
      <Option id="f2b2b" value="editor" label="Editor" />
      <Option id="f3c3c" value="viewer" label="Viewer" />
      <Event
        id="e1f2a3b4"
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="applyFilters"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Button
      id="refreshBtn"
      iconBefore="bold/interface-arrows-round-left"
      marginType="normal"
      text="Refresh"
    >
      <Event
        id="c5d6e7f8"
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="fetchUsers"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="usersTable"
      cellSelection="none"
      data="{{ Array.isArray(fetchUsers.data) ? fetchUsers.data : [{ id: 1, name: 'Alice Johnson', email: 'alice@example.com', role: 'admin', status: 'active', created_at: '2024-01-15T10:30:00Z' }, { id: 2, name: 'Bob Smith', email: 'bob@example.com', role: 'editor', status: 'active', created_at: '2024-02-20T14:15:00Z' }, { id: 3, name: 'Carol Davis', email: 'carol@example.com', role: 'viewer', status: 'inactive', created_at: '2024-03-10T09:00:00Z' }] }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      primaryKeyColumnId="a1b2c"
      rowHeight="medium"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      templatePageSize={20}
      toolbarPosition="bottom"
    >
      <Column
        id="a1b2c"
        alignment="right"
        format="decimal"
        key="id"
        label="ID"
        position="center"
        size={50}
      />
      <Column
        id="b2c3d"
        alignment="left"
        format="string"
        key="name"
        label="Name"
        position="center"
        size={180}
      />
      <Column
        id="c3d4e"
        alignment="left"
        format="link"
        formatOptions={{ showUnderline: "hover" }}
        key="email"
        label="Email"
        position="center"
        size={200}
      />
      <Column
        id="d4e5f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        key="role"
        label="Role"
        placeholder="Select option"
        position="center"
        size={100}
      />
      <Column
        id="e5f6a"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        key="status"
        label="Status"
        placeholder="Select option"
        position="center"
        size={100}
      />
      <Column
        id="f6a7b"
        alignment="left"
        format="datetime"
        key="created_at"
        label="Created"
        position="center"
        size={150}
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="Filter"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="Download"
        type="custom"
      >
        <Event
          id="d1e2f3a4"
          event="clickToolbar"
          method="exportData"
          pluginId="usersTable"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        id="b5c6d7e8"
        event="selectRow"
        method="show"
        params={{
          ordered: [
            { options: { object: { block: "nearest", behavior: "auto" } } },
          ],
        }}
        pluginId="drawerFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
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
        value="## Setup Guide"
        verticalAlign="center"
      />
    </Header>
    <Body>
      <Text
        id="setupGuideText"
        marginType="normal"
        value="{{ 'Welcome! This app demonstrates **RESTQuery** with a **DrawerFrame** detail panel, **EditableText** for inline editing, and **client-side filtering** via setFilterStack.\n\nTo connect your real API:\n\n1. Update the `fetchUsers` query URL to your API endpoint\n2. Update `updateUser`, `activateUser`, and `deactivateUser` query URLs and request bodies\n3. Remove the mock data fallback from the Table data attribute\n4. Delete this Setup Guide modal and the setupGuideBtn button\n\nClick any table row to open the detail drawer.' }}"
        verticalAlign="top"
      />
    </Body>
  </ModalFrame>
</App>
