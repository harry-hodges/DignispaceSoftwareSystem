// Form.jsx
import React from "react";

function Form({ inputValue, onInputChange, onAddTask }) {
  const handleChange = (event) => {
    onInputChange(event.target.value);
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    onAddTask();
  };

  return (
    <form className="form" onSubmit={handleSubmit}>
      <label>
        <input
          type="text"
          value={inputValue}
          onChange={handleChange}
          placeholder={`Type your ${inputValue} here...`}
        />
      </label>
      <button type="submit">Add</button>
    </form>
  );
}

export default Form;