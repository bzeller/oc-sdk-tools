/*
 * Copyright (C) 2016 Canonical Ltd
 * Copyright (C) 2017 Link Motion Oy
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Benjamin Zeller <benjamin.zeller@link-motion.com>
 */
package main

import (
	"encoding/json"
	"fmt"

	"github.com/bzeller/oc-sdk-tools"
)

type listCmd struct {
}

func (c *listCmd) usage() string {
	return (`Lists the existing SDK build targets.

ocsdk-target list`)
}

func (c *listCmd) flags() {
}

func (c *listCmd) run(args []string) error {

	lmTargets, err := lm_sdk_tools.FindOCTargets()
	if err != nil {
		return err
	}

	data, err := json.MarshalIndent(lmTargets, "  ", "  ")
	if err != nil {
		return err
	}

	fmt.Printf("%s\n", data)
	return nil
}
