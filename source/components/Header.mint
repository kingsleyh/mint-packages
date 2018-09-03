component Header {
  style brand {
    font-family: "Josefin Sans";
    text-decoration: none;
    align-items: center;
    font-weight: 400;
    font-size: 20px;
    display: flex;
    color: #FFF;
  }

  fun render : Html {
    <nav
      id="navbar"
      class="navbar has-shadow is-spaced is-light">

      <div class="container">
        <div class="navbar-brand">
          <a::brand
            class="navbar-item"
            href="/">

            <Logo
              mobileSize={20}
              invert={false}
              size={30}/>

            <div>
              <{ "MINT Packages" }>
            </div>

          </a>
        </div>
      </div>

    </nav>
  }
}
