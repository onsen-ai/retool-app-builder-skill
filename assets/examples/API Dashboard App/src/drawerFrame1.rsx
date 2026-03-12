<DrawerFrame
  id="drawerFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  overlayInteraction={true}
  padding="8px 12px"
  showOverlay={true}
  width="medium"
>
  <Button
    id="drawerCloseBtn"
    horizontalAlign="right"
    iconBefore="bold/interface-delete-1"
    style={{ ordered: [{ border: "transparent" }] }}
    styleVariant="outline"
  >
    <Event
      id="f1a2b3c4"
      event="click"
      method="setHidden"
      params={{ ordered: [{ hidden: true }] }}
      pluginId="drawerFrame1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Text
    id="drawerTitle"
    value="#### {{ usersTable.selectedRow.name }}"
    verticalAlign="center"
  />
  <EditableText
    id="editEmail"
    editIcon="bold/interface-edit-write-1"
    inputTooltip="`Enter` to save, `Esc` to cancel"
    label="Email"
    labelPosition="top"
    placeholder="Enter email"
    textSize="default"
    value="{{ usersTable.selectedRow.email }}"
  >
    <Event
      id="d5e6f7a8"
      event="change"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="updateUser"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </EditableText>
  <Text
    id="drawerRoleLabel"
    value="**Role:** {{ usersTable.selectedRow.role }}"
    verticalAlign="center"
  />
  <Text
    id="drawerStatusLabel"
    value="**Status:** {{ usersTable.selectedRow.status }}"
    verticalAlign="center"
  />
  <Text
    id="drawerCreatedLabel"
    value="**Created:** {{ usersTable.selectedRow.created_at }}"
    verticalAlign="center"
  />
  <Button
    id="activateBtn"
    disabled="{{ usersTable.selectedRow.status === 'active' }}"
    marginType="normal"
    text="Activate"
  >
    <Event
      id="a9b0c1d2"
      event="click"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="activateUser"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
  <Button
    id="deactivateBtn"
    disabled="{{ usersTable.selectedRow.status !== 'active' }}"
    marginType="normal"
    styleVariant="danger"
    text="Deactivate"
  >
    <Event
      id="e3f4a5b6"
      event="click"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="deactivateUser"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
  </Button>
</DrawerFrame>
