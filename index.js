const { getRandomUsers } = require('./api');
const { User, client } = require('./models');
//
(async () => {
  const users = await getRandomUsers({
    page: 33,
  });
  await User.bulkCreate(users);
  client.end();
})();
