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
      value="### Hello, Retool!
This is the simplest valid Retool app."
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
        value="{{ 'Welcome! This is the **Minimal App** template — the simplest valid Retool app.\n\nUse it as a starting point to build anything. Add components, queries, and event handlers to create your app.\n\nWhen you are done, delete this Setup Guide modal and the setupGuideBtn button.' }}"
        verticalAlign="top"
      />
    </Body>
  </ModalFrame>
</App>
