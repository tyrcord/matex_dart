#!/usr/bin/env node --no-warnings
import { Command } from 'commander';

import { update } from './commands';

const program = new Command();

program.version('0.2.0');

program
  .command('update')
  .description('update instrument definitions')
  .action(update);

program.parse(process.argv);
