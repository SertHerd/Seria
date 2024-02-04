const axios = require('axios');
const moment = require('moment-timezone');
const dataFilePath = 'data.json';

let data;
try {
    data = require('./data.json');
} catch (error) {
    console.error('Error loading data:', error.message);
    data = {};
}
const currentUrl = window.location.href;

const urlObject = new URL(currentUrl);

const hwid = urlObject.searchParams.get("hwid");

if (hwid) {
  console.log("hwid:", hwid);
      if (data[hwid]) {
        const currentDateTime = moment().tz('Asia/Ho_Chi_Minh');
        const keyExpirationDateTime = moment(data[hwid].ngay_het_han, 'DD-MM-YYYY HH:mm:ss');

        if (currentDateTime.isBefore(keyExpirationDateTime)) {
            res.json({ success: true, link_get_key: `${data[hwid].link_get_key}` });
        } else {
            try {
                const link_get_key = await gen_link_get_key(code);
                data[hwid] = {
                    key: `${code}`,
                    link_get_key: `${link_get_key}`,
                    ngay_het_han: `${ngay_het_han}`,
                };
                fs.writeFileSync(dataFilePath, JSON.stringify(data, null, 2), 'utf-8');
                res.json({ success: true, link_get_key, ngay_het_han });
            } catch (error) {
                console.error('Error generating link_get_key:', error.message);
                res.json({ success: false, error: 'Failed to generate link_get_key' });
            }
        }
    } else {
        try {
            const link_get_key  = await gen_link_get_key(code);
            data[hwid] = {
                key: `${code}`,
                link_get_key,
                ngay_het_han: `${ngay_het_han}`,
            };
            fs.writeFileSync(dataFilePath, JSON.stringify(data, null, 2), 'utf-8');
            res.json({ success: true, link_get_key, ngay_het_han });
        } catch (error) {
            console.error('Error generating link_get_key:', error.message);
            res.json({ success: false, error: 'Failed to generate link_get_key' });
        }
    }
} else {
  console.log("Thiếu tham số hwid");
}

