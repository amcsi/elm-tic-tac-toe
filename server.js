const express = require('express');
const compress = require('compression');

const app = express();
const publicPath = './public';

const staticMiddleware = express.static(publicPath, {
  maxage: 31557600,
});

function notFoundMiddleware (req, res) {
  res.status(404).send('Not found');
};

app.use(compress());
app.use(staticMiddleware);
app.use(notFoundMiddleware);

const server = app.listen(process.env.PORT || 8080, () => {
  const host = server.address().address;
  const port = server.address().port;

  console.log('App listening at http://%s:%s', host, port);
});

