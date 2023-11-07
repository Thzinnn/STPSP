
document.addEventListener("DOMContentLoaded", () => {
  displayFlashMessage();

  const form = document.querySelector("#form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    //coleta dos dados do form
    if (form.checkValidity()) {
      const nomeCompleto = document.querySelector("#nomeCompleto").value;
      const CPF = document.querySelector("#CPF").value;
      const email = document.querySelector("#email").value;
      const nascimento = document.querySelector("#nascimento").value;
      const senha = document.querySelector("#senha").value;
      const numeroTel = document.querySelector("#numeroTel").value;
      //forma de guarda-los em um array
      const data = { nomeCompleto, CPF, email, nascimento, senha, numeroTel };

      try {
        const response = await axios.post("http://localhost:5000/api/motoristas/cadastrar", data);
      
        storeFlashMessage("success", "Cadastro realizado sucesso");

      } catch (error) {
        storeFlashMessage("danger", error.message);
      }
    }
    
    form.classList.add("was-validated");
    window.location.href = 'http://localhost:3000/admin/cadastrar-motorista';
  });
});