const { DataTypes } = require('sequelize');
const connection = require('../db');

const CommentsModel = connection.define('Comments', {
   id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
   },
   userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
   },
   productId: {
      type: DataTypes.INTEGER,
      allowNull: false,
   },
   comment: {
      type: DataTypes.TEXT,
      allowNull: true,
   },
}, {
   tableName: 'comments',
   timestamps: false,
});

module.exports = CommentsModel;