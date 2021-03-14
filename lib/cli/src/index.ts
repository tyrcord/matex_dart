#!/usr/bin/env node --no-warnings
import * as program from 'commander';

import { update } from './commands';

program.version('0.2.0');

program
  .command('update')
  .description('update instrument definitions')
  .action(update);

program.parse(process.argv);
