@react.component
let make = () => {
  <div className="p-5"> {React.string("I'm a test component?! HMR works!")} </div>
}

module Test = {
  @react.component
  let make = () => {
    <div className="p-5"> {React.string("I'm a test component?! HMR works!!")} </div>
  }
}
