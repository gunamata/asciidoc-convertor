## 1. Tabs

<Tabs>
  <TabItem value="apple">
    This is an apple.
  </TabItem>
  <TabItem value="orange">
    This is an orange.
  </TabItem>
  <TabItem value="banana">
    This is a banana.
  </TabItem>
</Tabs>

## 2. Tabs with default

<Tabs>
  <TabItem value="apple">
    This is an apple.
  </TabItem>
  <TabItem value="orange" default>
    This is an orange.
  </TabItem>
  <TabItem value="banana">
    This is a banana.
  </TabItem>
</Tabs>

## 3. Tabs with labels

<Tabs>
  <TabItem value="apple" label="Apple" default>
    This is an apple 🍎
  </TabItem>
  <TabItem value="orange" label="Orange">
    This is an orange 🍊
  </TabItem>
  <TabItem value="banana" label="Banana">
    This is a banana 🍌
  </TabItem>
</Tabs>

## 4. Tabs with syncing

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">Use Ctrl + C to copy.</TabItem>
  <TabItem value="mac" label="macOS">Use Command + C to copy.</TabItem>
</Tabs>

<Tabs groupId="operating-systems">
  <TabItem value="win" label="Windows">Use Ctrl + V to paste.</TabItem>
  <TabItem value="mac" label="macOS">Use Command + V to paste.</TabItem>
</Tabs>

## 5. Tabs nested in another element

1. Some text.

1. More text.
    <Tabs>
    <TabItem value="Add a new persistent volume">

      1. Enter a **Name** for the volume claim.
      1. Select a volume claim **Source**:
          - If you select **Use a Storage Class to provision a new persistent volume**, select a storage class and enter a **Capacity**.
          - If you select **Use an existing persistent volume**, choose a **Persistent Volume** from the drop-down.
      1. From the **Customize** section, choose the read/write access for the volume.
      1. Click **Define**.

    </TabItem>
    <TabItem value="Use an existing persistent volume">

      1. Enter a **Name** for the volume claim.
      1. Choose a **Persistent Volume Claim** from the dropdown.
      1. From the **Customize** section, choose the read/write access for the volume.
      1. Click **Define**.

    </TabItem>
    </Tabs>

1. Final text.