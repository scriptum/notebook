import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Open up App.js to start working on your app!</Text>
        <Text>Changes you make will automatically reload.</Text>
        <Text>Shake your phone to open the developer menu.</Text>
        <View style={styles.tabBar}>
          <Text>Test</Text>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  tabBar: {
    flex: 1,
    backgroundColor: '#fff',
    position: "absolute",
    bottom: 0,
    height: 56,
    elevation: 8,
    width: "100%",
    alignItems: 'center',
    justifyContent: 'center',
    opacity: 1
  },
});
