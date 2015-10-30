Fabricator(:payment) do
  loan { Fabricate(:loan) }
  amount { 100 }
end