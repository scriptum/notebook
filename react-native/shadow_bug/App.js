import React from 'react';
import {StyleSheet, Text, View} from 'react-native';

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Try landscape and portrait modes.</Text>
        <View style={styles.bottomBar} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  },
  bottomBar: {
    flex: 1,
    backgroundColor: '#efe',
    position: 'absolute',
    bottom: 0,
    height: 56,
    elevation: 8,
    width: '100%'
  }
});
