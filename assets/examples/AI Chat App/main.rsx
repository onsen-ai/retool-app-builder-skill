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
      value="### AI Assistant"
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
    <Chat
      id="chatBox"
      _sessionStorageId="00000000-0000-0000-0000-000000000099"
      assistantName="AI Assistant"
      placeholder="Ask me anything..."
      queryTargetId="sendMessage"
      showAvatar={true}
      showEmptyState={true}
      showHeader={true}
      showTimestamp={true}
      emptyTitle="Welcome!"
      emptyDescription="Start a conversation with the AI assistant."
    />
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
        value="{{ 'Welcome! This app demonstrates the **AI Chat** pattern with a Chat component and RESTQuery.\n\nTo connect your real AI backend:\n\n1. Open the `sendMessage` query in the bottom panel\n2. Update the API URL and request body to match your AI provider\n3. Update the **sendMessage** query transformer to extract the response\n4. Delete this Setup Guide modal and the setupGuideBtn button\n\nThe Chat component is already wired — just swap the backend.' }}"
        verticalAlign="top"
      />
    </Body>
  </ModalFrame>
</App>
