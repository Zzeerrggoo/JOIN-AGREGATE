const _ = require('lodash');
const { getRandomUsers } = require('./api');
const { User, Phone, client } = require('./models');
const { generatePhones } = require('./utils/phones');
//
//
(async () => {
  const users = await User.bulkCreate(await getRandomUsers({ page: 5 }));
  const phones = await Phone.bulkCreate(generatePhones());

  /**
   * smell code
   *    ||
   *    \/
   */
  const ordersValues = users
    .map(u => `(${u.id}),`.repeat(_.random(1, 10)))
    .join('');
  const { rows: orders } = await client.query(`INSERT INTO orders ("userId")\n
  VALUES ${ordersValues.slice(0, ordersValues.length - 1)}\n
  RETURNING id;`);

  const ordersToPhonesValues = orders
    .map(o => {
      const buf = [];
      const phonesCount = _.random(1, phones.length - 1);
      for (let i = 0; i < phonesCount; ++i) {
        buf.push(`(${o.id},${phones[i].id}, ${_.random(1, 10)})`);
      }
      return buf.join(',');
    })
    .join(',');

  await client.query(`INSERT INTO orders_to_phones ("orderId", "phoneId", "quantity")\n
  VALUES ${ordersToPhonesValues};`);

  client.end();
})();
