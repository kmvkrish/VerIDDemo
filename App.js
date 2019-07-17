/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  Text,
  StatusBar,
  Button
} from 'react-native';

import ContainerView from './components/containerView';
import CredentialsAuthView from './components/CredentialsAuthView';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      authMode: "credentials"
    };
  }

  componentDidMount() {
    StatusBar.setHidden(true, "slide");
  }

  switchAuthMode(authMode) {
    this.setState({
      authMode: authMode
    });
  }

  render() {
    return (
      <View style={styles.containerStyle}>
        {
          this.state.authMode == "biometrics" ? <ContainerView style={styles.leftContainer} /> : null
        }
        {
          this.state.authMode == "credentials" ? <CredentialsAuthView style={styles.leftContainer} /> : null
        }
        <View style={styles.rightContainer}>
          <Text style={styles.textColor}>Choose the authentication mode.</Text>
          <Button title="Use Credentials" onPress={() => this.switchAuthMode("credentials")} />
          <Button onPress={() => this.switchAuthMode("biometrics")} title="Use Biometrics" />
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  containerStyle: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: 'black'
  },
  leftContainer: {
    flex: 7,
    // backgroundColor: 'blue',
    alignContent: 'center',
    justifyContent: 'center',
    alignItems: 'center'
  },
  rightContainer: {
    flex: 3,
    backgroundColor: 'white',
    justifyContent: 'center',
    alignItems: 'center',
  },
  textColor: {
    color: 'black',
    fontSize: 12,
    fontWeight: "bold",
    marginBottom: 10
  }
});