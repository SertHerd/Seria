import axios from 'axios';
import moment from 'moment-timezone';
const currentUrl = window.location.href;
const urlObject = new URL(currentUrl);

const hwid = urlObject.searchParams.get("hwid");
async function main() {
    const dataFilePath = 'data.json';

    let data;
    try {
        data = require('./data.json');
        console.log('ok')
    } catch (error) {
        console.error('Error loading data:', error.message);
        data = {};
    }
    async function gen_key(chuso) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let result = 'HN-';
        const charactersLength = characters.length;
        for (let i = 0; i < chuso; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }

    async function create_note(content,title) {
        try {
            const response = await axios.get(`https://web1s.com/note-api?token=${config.api_note}&content=${content}&title=${title}`)
            console.log("Data: ", response.data);
            console.log("Link rút gọn: ", response.data.shortenedUrl);
            return response.data.shortenedUrl
        } catch (error) {
            console.error('Yêu cầu thất bại:', error.message);
            return null;
        }
    }

    async function gen_link_get_key(code) {
        try {
            const destinationUrl = await create_note(`PS99 AUTO RANK KEY: ${code}`, `From HN GAMING With Love`);
            const response = await axios.get(`https://web1s.com/api?token=${config.api_link}&url=${destinationUrl}`)
            console.log("Data: ", response.data);
            console.log("Link rút gọn: ", response.data.shortenedUrl);
            return response.data.shortenedUrl
        } catch (error) {
            console.error('Yêu cầu thất bại:', error.message);
            return null;
        }
    }
    if (hwid) {
    console.log("hwid:", hwid);
        if (data[hwid]) {
            console.log(`valid...`);
            const code = await gen_key(20)
            console.log(code)
            const currentDateTime = moment().tz('Asia/Ho_Chi_Minh');
            const keyExpirationDateTime = moment(data[hwid].ngay_het_han, 'DD-MM-YYYY HH:mm:ss');

            if (currentDateTime.isBefore(keyExpirationDateTime)) {
                console.log({ success: true, link_get_key: `${data[hwid].link_get_key}` });
            } else {
                try {
                    const link_get_key = await gen_link_get_key(code);
                    data[hwid] = {
                        key: `${code}`,
                        link_get_key: `${link_get_key}`,
                        ngay_het_han: `${ngay_het_han}`,
                    };
                    fs.writeFileSync(dataFilePath, JSON.stringify(data, null, 2), 'utf-8');
                    console.log({ success: true, link_get_key, ngay_het_han });
                } catch (error) {
                    console.error('Error generating link_get_key:', error.message);
                    console.log({ success: false, error: 'Failed to generate link_get_key' });
                }
            }
        } else {
            console.log(`create...`);
            try {
                const link_get_key  = await gen_link_get_key(code);
                data[hwid] = {
                    key: `${code}`,
                    link_get_key,
                    ngay_het_han: `${ngay_het_han}`,
                };
                fs.writeFileSync(dataFilePath, JSON.stringify(data, null, 2), 'utf-8');
                console.log({ success: true, link_get_key, ngay_het_han });
            } catch (error) {
                console.error('Error generating link_get_key:', error.message);
                console.log({ success: false, error: 'Failed to generate link_get_key' });
            }
        }
    } else {
    console.log("Thiếu tham số hwid");
    }
}
main()
