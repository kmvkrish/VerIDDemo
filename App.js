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
  Button,
  UIManager,
  findNodeHandle
} from 'react-native';

import VerIDSessionView from './components/VerIDSessionView';
import CredentialsAuthView from './components/CredentialsAuthView';

export default class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      authMode: "biometrics"
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

  startSession = () => {
    var handle = findNodeHandle(this.refs.verid);
    if (!handle) {
      return;
    }
    UIManager.dispatchViewManagerCommand(
        handle,
        UIManager.getViewManagerConfig('RCTSessionView').Commands.startSession,
        [],
    );
  }

  stopSession = () => {
    var handle = findNodeHandle(this.refs.verid);
    if (!handle) {
      return;
    }
    UIManager.dispatchViewManagerCommand(
        handle,
        UIManager.getViewManagerConfig('RCTSessionView').Commands.stopSession,
        []
    );
  }

  render() {
    return (
      <View style={styles.containerStyle}>
        {
          this.state.authMode == "biometrics" ? <VerIDSessionView style={styles.leftContainer} ref="verid" /> : null
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