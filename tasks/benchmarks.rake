
desc 'Run benchmark suite'
task :benchmark do
  sh 'ruby examples/benchmarks.rb'
end