const express = require('express')

const TodoCtrl = require('../controllers/todo-ctrl')

const router = express.Router()

router.post('/todo', TodoCtrl.createTodo)
router.put('/todo/:id', TodoCtrl.updateTodo)
router.delete('/todo/:id', TodoCtrl.deleteTodo)
router.get('/todo/:id', TodoCtrl.getTodoById)
router.get('/todos', TodoCtrl.getTodos)

module.exports = router