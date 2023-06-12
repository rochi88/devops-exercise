import { useState } from "react";
import axios from "axios";

export default function Home() {
  const [value, updateValue] = useState("create new todo");
  const [input, setInput] = useState("");
  const baseUrl = "http://localhost:5001";
  const getTodoUrl = `${baseUrl}/todo`;
  const createTodoUrl = `${baseUrl}/create`;

  const getTodo = async () => {
    try {
      const { data } = await axios.get(getTodoUrl);
      updateValue(data);
      console.log({ message: "got todo", data });
      return res;
    } catch (error) {
      console.error({ message: "failed fetching todo.", error });
    }
  };

  const createTodo = async (inputText) => {
    try {
      const { data } = await axios.post(createTodoUrl, { data: inputText });
      console.log({ message: "posted todo", data });
      return data;
    } catch (error) {
      console.error({ message: "failed creating todo.", error });
    }
  };

  const handleSubmit = async (evt) => {
    evt.preventDefault();
    await createTodo(input);
    setInput("");
  };

  return (
    <main style={{ display: "grid", placeItems: "center", height: "100vh" }}>
      <section style={{ zoom: "1.2", display: "grid", placeItems: "center" }}>
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            value={input}
            onChange={(evt) => setInput(evt.target.value)}
          />
          <input type="submit" value="create todo" />
        </form>
        <button onClick={getTodo} style={{ margin: "1rem 0" }}>
          get todo
        </button>
      </section>
      <section style={{ height: "80vh" }}>
        <h3 style={{ textAlign: "center" }}>output</h3>
        <pre>{JSON.stringify(value, null, 2)}</pre>
      </section>
    </main>
  );
}