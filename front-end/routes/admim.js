var express = require("express");
var router = express.Router();

router.get("/cadastrar-cliente", function (req, res, next) {
  res.render("admim/cadastrar-cliente");
});

router.get("/cadastrar-motorista", function (req, res, next) {
  res.render("admim/cadastrar-motorista");
});

router.get("/cadastrar-linha", function (req, res, next) {
  res.render("admim/cadastrar-linha");
});



module.exports = router;