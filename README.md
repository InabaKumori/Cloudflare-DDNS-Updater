# Cloudflare DDNS Updater

Cloudflare DDNS Updater is a simple shell script designed to automatically update a Cloudflare DNS record with your current public IP address, making it an ideal solution for dynamic DNS setups. This script checks for IP address changes every minute, and if a change is detected, it updates the DNS record on Cloudflare using their API.

## Getting Started

These instructions will get you a copy of the project up and running on your own machine for development and testing purposes.

### Prerequisites

Before running this script, you will need:

- A Cloudflare account and an API key
- `jq` installed on your system for parsing JSON (Install using `apt-get install jq` on Debian/Ubuntu or `yum install jq` on CentOS/RHEL)
- `curl` installed on your system

### Installation

1. Clone this repository or download the script to your local machine.
2. Make the script executable:
   ```bash
   chmod +x update_dns.sh
   ```
3. Edit the script to include your Cloudflare details:
    - `API_KEY`: Your Cloudflare API key
    - `ZONE_ID`: The zone ID of your domain
    - `RECORD_NAME`: The DNS record you wish to update

### Setting Up Cron Job

To ensure the DNS record is automatically updated on reboot and regularly checks for IP changes, you need to set up a cron job.

1. Open your crontab file:
   ```bash
   crontab -e
   ```
2. Add the following line to run the script at reboot and keep it running:
   ```bash
   @reboot /usr/bin/screen -dmS update_dns /path/to/your/update_dns.sh
   ```
   Replace `/path/to/your/` with the actual path to where you've saved `update_dns.sh`.
3. Save and close the editor. You can verify that your cron job is set up by listing the active cron jobs:
   ```bash
   crontab -l
   ```

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- This script is designed for those who need a simple solution to keep their Cloudflare DNS records updated with their dynamic IP address.

---
