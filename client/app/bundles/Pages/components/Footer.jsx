import React from 'react';

let Footer = props => {
  return (
    <footer className="footer">
      <p>Warlocks Mind made with love by Kaemon Lovendahl</p>
      <p>This website is not produced, endorsed, supported, or affiliated with Wizards of the Coast.</p>
      <nav>
        <ul className="footer__links">
          <li><a href="http://kaemonlovendahl.herokuapp.com/" target="_blank">My Portfolio</a></li>
        </ul>
      </nav>
    </footer>
  )
}

export { Footer }