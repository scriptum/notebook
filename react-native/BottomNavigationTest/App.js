// @flow

import React from 'react';
import {StyleSheet, Text, View, ScrollView, Image, Button} from 'react-native';
import {TabNavigator, StackNavigator} from 'react-navigation';
import Lorem from './Components/Lorem';
import TabBar from './Components/TabBar';

// const Lorem = () => <Lorem />;

const HomeScreen = (props: Object) => (
  <View styel={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
    <ScrollView>
      <Text>{JSON.stringify(props)}</Text>
    </ScrollView>

    <Button
      title='Go to Details'
      onPress={() => props.navigation.navigate('Details')}
    />
  </View>
);

const SettingsScreen = (props: Object) => (
  <View syle={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
    <ScrollView>
      <Text>{JSON.stringify(props)}</Text>
    </ScrollView>
    <Button
      title='Go to Details'
      onPress={() => props.navigation.navigate('Details')}
    />
  </View>
);

const HomeStack = StackNavigator({
  Home: {screen: HomeScreen},
  Details: {screen: Lorem},
});

const SettingsStack = StackNavigator({
  Settings: {screen: SettingsScreen},
  Details: {screen: Lorem},
});

export default TabNavigator(
  {
    Home: {screen: HomeStack},
    Settings: {screen: SettingsStack},
  },
  {
    // tabBarComponent: TabBar,
    animationEnabled: false,
    lazy: false,
  },
);
