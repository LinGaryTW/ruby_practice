class HashTable
	class Slot
		attr_accessor :key, :value, :vacated

		def initialize key, value
			@key     = key
			@value   = value
			@vacated = false
		end
		
		# Marks the slot as free.
		def free
			self.value   = nil
			self.vacated = true
		end
	end

	# Appropiate number of slots for incremental rebuilds.
	# On production hash tables this array sould contain
	# way more entries. May the max number of entries
	# shold be up to a couple of millions.
	PRIMES = [13, 31, 61, 127, 251, 509]
	MAX_REBUILDS = 6 # Up most equal to PRIMES.count

	attr_accessor :size

	def initialize
		# To ensure that all slots are visited before any position gets
		# visited twice, we have to set *slots* to a prime number and make 
		# sure that *h2* returns a possitive number less than slots.
		# To keep the load factor healthy, the number of *slots* should 
		# roughly two times the number of keys we need to store.
		# We start with just few entries.
		@slots    = 5
		@size = 0
		@rebuilds = 0
		@h1       = -> (k) { k % @slots }
		@h2       = -> (k) { 1 + (k % (@slots - 1)) }
		fill_table @slots
	end

	# Idiomatic way to get an entry.
	def [](key)
		get(key)
	end

	# Idiomatic way to upsert an entry.
	def []=(key, value)
		upsert(key, value)
	end

	def delete key
		find_slot(key)&.free
	end

	# Prints the contents of the hash table.
	# (Mostly for debugging purposes.)
	def print
		@table.each do |e|
			if e
				puts "#{e.key}: #{e.value}"
			else
				puts "empty"
			end
		end
	end
	

private

	def get key
		find_slot(key)&.value
	end

	def double_hash hashcode, idx
		h1 = @h1.call(hashcode)
		h2 = @h2.call(hashcode)
		((h1 + (idx * h2)) % @slots).abs()
	end


	# Initializes the internal storage for the hash table.
	def fill_table slots
		@table = []
		0.upto(slots - 1) { @table << nil }
	end
	
	# Rebuilds the hash table to accommodate more entries.
	def rebuild
		raise "Too many entries." if @rebuilds >= MAX_REBUILDS

		old   = @table
		@slots = PRIMES[@rebuilds]
		self.size = 0
		fill_table @slots
		old.each do |e|
			upsert e.key, e.value if e
		end
		@rebuilds += 1
	end

	# Inserts a new entry or updates an existing one.
	def upsert key, value
		# Is there enough room for the new entry.
		rebuild if self.size > (@slots / 2)

		# If an entry already exists, update an return.
		if (slot = find_slot(key))
			slot.value = value
			return
		end

		# "Double hash" the key to an index position and
		# insert the new entry.
		0.upto(@slots - 1) do |i|
			# We use the hashcode for the key, not the
			# key itself.
			index = double_hash key.hash, i
			slot  = @table[index]
			if slot.nil? || slot.vacated 
				@table[index] = Slot.new key, value
				self.size += 1
				return
			end
		end
		raise "Weak hash function."
	end

	# Returns the slot in the table that matches the 
	# given key or nil is there isn't one.
	def find_slot key
		# double hash key to index.
		0.upto(@slots - 1) do |i|
			# Again, we use the key's hash code
			# not the key itself.
			index = double_hash key.hash, i
			slot  = @table[index]
			return nil  if slot.nil? || slot.vacated
			return slot if slot.key == key
		end
		nil
	end
end