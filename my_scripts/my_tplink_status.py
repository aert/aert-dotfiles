#!/usr/bin/env python

# requirements:
# $ pip install 'requests~=2.22'

import requests
import math


class TpLinkStatus:
    HOST = "192.168.0.1"

    def run(self):
        rv = self.call_api()

        r_bat = int(rv["battery"]["voltage"])
        r_charging = bool(rv["battery"]["charging"])
        r_tx = self.human(rv["wan"]["txSpeed"], num_decs=1, width=7)
        r_rx = self.human(rv["wan"]["rxSpeed"], num_decs=1, width=7)
        r_daily = self.human(rv["wan"]["dailyStatistics"])
        r_total = self.human(rv["wan"]["totalStatistics"])
        r_devices = rv["connectedDevices"]["number"]
        r_strength = int(rv["wan"]["signalStrength"])

        section_speed = f"{r_tx}/{r_rx}"
        section_totals = f"Today:{r_daily} Total:{r_total}"
        section_devices = f"{r_devices} {'⣿' * r_strength + '⣀' * (4-r_strength)}"
        section_bat = self.display_bat(r_charging, r_bat)

        return f"{section_speed} ¤ {section_totals} ¤ {section_devices} ¤ M7350⚡{section_bat}"

    def display_bat(self, charging, value):
        if value > 99:
            return ""

        bar_full = "⣿" if charging else "█"
        bar_empty = "▁" if charging else "░"
        num_bars = math.floor(4 * value / 100)
        return f"({bar_full * num_bars}{bar_empty * (4-num_bars)})"

    def human(self, size, **kwargs):
        size = float(size or 0)
        width = kwargs.get("width", None)
        if size == 0:
            return "." if width is None else ".".center(width)

        units = kwargs.get("units", ["B", "kB", "MB", "GB", "TB"])
        num_decs = kwargs.get("num_decs", 2)
        no_unit = kwargs.get("no_unit", False)

        i = math.floor(math.log(size) / math.log(1024))
        value = size / math.pow(1024, i)
        unit = units[i]
        rv = f"{value:.{num_decs}f}{'' if no_unit else unit}"
        return rv if width is None else rv.center(width)

    def call_api(self):
        cookies = {"check_cookie": "check_cookie"}

        headers = {
            "Origin": f"http://{self.HOST}",
            "Accept-Encoding": "gzip, deflate",
            "Accept-Language": "en-US,en;q=0.9",
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36",
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Referer": f"http://{self.HOST}/login.html",
            "X-Requested-With": "XMLHttpRequest",
            "Connection": "keep-alive",
        }

        data = '{"module":"status","action":0}'

        r = requests.post(
            f"http://{self.HOST}/cgi-bin/web_cgi",
            headers=headers,
            cookies=cookies,
            data=data,
            verify=False,
            timeout=2,
        )

        return r.json()


if __name__ == "__main__":
    runner = TpLinkStatus()
    try:
        print(runner.run())
    except requests.exceptions.ConnectionError:
        print("M7350(down)")
    except Exception as ex:
        print("M7350(down)", ex)
