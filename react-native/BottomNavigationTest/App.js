import React from "react";
import { StyleSheet, Text, View, ScrollView, Image } from "react-native";

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
      <Image source={require("./shadow.png")} style={styles.shadowTop} />
        <ScrollView>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu.</Text>
          <Text>Open up App.js to start working on your app!</Text>
          <Text>Changes you make will automatically reload.</Text>
          <Text>Shake your phone to open the developer menu....</Text>
        </ScrollView>
        <Image source={require("./shadow.png")} style={styles.shadow} />

        <View style={styles.tabBar}>
          <Text style={{ fontSize: 10 }}>Test</Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "space-between"
  },
  shadow: {
    // bottom: 56,
    height: 10,
    marginTop: -10,
    // position: "absolute",
    width: "100%",
    resizeMode: "stretch",
    opacity: 0.2,
    // transform: [{ rotateX: "180deg" }],
  },
  shadowTop: {
    // bottom: 56,
    height: 26,
    marginBottom: -26,
    // position: "absolute",
    width: "100%",
    resizeMode: "stretch",
    opacity: 0.8,
    // blurradius: 10,
    transform: [{ rotateX: "180deg" }],
  },
  tabBar: {
    flex: 0,
    backgroundColor: "#fff",
    // position: "absolute",
    // bottom: 0,
    height: 56,
    // elevation: 8,
    width: "100%",
    alignItems: "center",
    justifyContent: "center",
    opacity: 1
  }
});
