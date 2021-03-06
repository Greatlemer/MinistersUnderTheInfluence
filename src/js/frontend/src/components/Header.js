import React from "react";
import Radium from "radium";
import Logo from "./Logo";
import Navigation from "./Navigation";

class Header extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <header
      style={[
        styles.base,
      ]}>
        <Logo />
        <Navigation />
      </header>
    )
  }
}

var shadow = 'inset #F2E9E9 0px -2px 0px 0px';

var styles = {
  base: {
    // backgroundColor: '#F5F5ED',
    height: "12vh",
    borderBottom: '5px solid white',
    WebkitBoxShadow: shadow,
    MozBoxShadow: shadow,
    boxShadow: shadow,
    borderBottom: '2px solid #333',
  }
};

export default Radium(Header);
