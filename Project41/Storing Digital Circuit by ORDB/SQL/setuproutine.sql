create function checkinput (l int)
	returning char;
	define inp collection;
	define outp collection;
	define ret int;
	define ret1 int;
	define n int;
	define count int;

	foreach
		select input into inp from andgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from orgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from notgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from nandgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from norgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from xorgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from xnorgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	foreach
		select input into inp from newgate where gid in (select gid from layout where lid = l)
		foreach
			select  * into n from table(inp)
			let count = 0;
			foreach
				select gid,output into ret,outp from andgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from orgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from notgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from nandgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from norgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from xnorgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			foreach
				select gid,output into ret,outp from newgate where n in output
				foreach
					select * into ret1 from table(outp)
					if ret1 = n then let count = count + 1;
					end if;
				end foreach;
			end foreach;
			if (select isoutput from wired where wid = n) = 'I' then let count = count + 1;
			end if;
			if count > 1 then return 'N';
			end if;
		end foreach;
	end foreach;
	return 'Y';
end function;

create function checkloop (l int)
	returning char;
	define ret int;
	define ret1 int;
	define ret2 int;
	define ret3 int;
	define work1 set(int not null);
	define path set(int not null);
	define iswork char;
	define temp collection;
	define temp1 set(int not null);
	define count int;
	define tempwork int;

	foreach
		select gid into ret from layout where lid = l
		let path = "set{}";
		let work1 =  "set{}";
		insert into table(work1) values(ret);
		let iswork = 'Y';
		while(iswork = 'Y')
			let iswork = 'N';
			let count = 0;
			let temp1 = "set{}";
			foreach
				select * into tempwork from table(work1)
				let count = count +1;
				let iswork = 'Y';
				if count > 1 then
					insert into table(temp1) values(tempwork);
				elif count = 1 then
					let ret1 = tempwork;
				end if;
			end foreach;
			if iswork = 'N' then continue while;
			end if;
			delete from table(work1);
			foreach
				select * into tempwork from table(temp1)
				insert into table(work1) values(tempwork);
			end foreach;
			select output into temp from andgate where gid = ret1;
			if temp is null then 
				select output into temp from orgate where gid = ret1;
				if temp is null then 
					select output into temp from notgate where gid = ret1;
					if temp is null then 
						select output into temp from nandgate where gid = ret1;
						if temp is null then 
							select output into temp from norgate where gid = ret1;
							if temp is null then 
								select output into temp from xorgate where gid = ret1;
								if temp is null then 
									select output into temp from xnorgate where gid = ret1;
									if temp is null then 
										select output into temp from newgate where gid = ret1;
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
			foreach
				select * into ret2 from table(temp)
				foreach
					select gid into ret3 from andgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from orgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from notgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from nandgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from norgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from xorgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from xnorgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
				foreach
					select gid into ret3 from newgate where ret2 in input
					if ret3 is not null and ret3 not in (select * from table(path)) then 
						insert into table(path) values(ret3);
						insert into table(work1) values(ret3);
					end if;
				end foreach;
			end foreach;
			if ret in (select * from table(path)) then return 'N';
			end if;
		end while;
	end foreach;
	return 'Y';
end function;

create function clearlayout (l int)
	returning int;
	define ret int;

	foreach
		execute function getwid(l) into ret
		delete from wired where wid = ret;
	end foreach;
	delete from andgate where gid in (select gid from layout where lid = l);
	delete from orgate where gid in (select gid from layout where lid = l);
	delete from notgate where gid in (select gid from layout where lid = l);
	delete from nandgate where gid in (select gid from layout where lid = l);
	delete from norgate where gid in (select gid from layout where lid = l);
	delete from xorgate where gid in (select gid from layout where lid = l);
	delete from xnorgate where gid in (select gid from layout where lid = l);
	delete from newgate where gid in (select gid from layout where lid = l);
	delete from layout where lid = l;
end function;

create function genarateand (input1 char,input2 char)
	returning char;

	if input1 = 'H' and input2 = 'H' then return 'H';
	else return 'L';
	end if
end function;

create function genarateor (input1 char,input2 char)
	returning char;

	if input1 = 'L' and input2 = 'L' then return 'L';
	else return 'H';
	end if
end function;

create function genaratenot (input1 char)
	returning char;

	if input1 = 'H' then return 'L';
	else return 'H';
	end if
end function;

create function genaratenand (input1 char,input2 char)
	returning char;

	if input1 = 'H' and input2 = 'H' then return 'L';
	else return 'H';
	end if
end function;

create function genaratenor (input1 char,input2 char)
	returning char;

	if input1 = 'L' and input2 = 'L' then return 'H';
	else return 'L';
	end if
end function;

create function genaratexor (input1 char,input2 char)
	returning char;

	if input1 = input2 then return 'H';
	else return 'L';
	end if
end function;

create function genaratexnor (input1 char,input2 char)
	returning char;

	if input1 = input2 then return 'L';
	else return 'H';
	end if
end function;

create function genaratefinal (l int)
	returning int;
	define n int;
	define count int;
	define ret int;

	let count = 1;
	let ret = 0;
	while count > 0
		let count = 0;
		execute function getgenand(l) into n;
		let count = count + n;
		execute function getgenor(l) into n;
		let count = count + n;
		execute function getgennot(l) into n;
		let count = count + n;
		execute function getgennand(l) into n;
		let count = count + n;
		execute function getgennor(l) into n;
		let count = count + n;
		execute function getgenxor(l) into n;
		let count = count + n;
		execute function getgenxnor(l) into n;
		let count = count + n;
		execute function getgennew(l) into n;
		let count = count + n;
		let ret = ret + count;
	end while;
	return ret;
end function;

create function getelement (column list(int not null),number int)
	returning int;
	define n int;
	define count int;

	let count = 0;

	foreach cursor1 for
		select  * into n from table(column)
		let count = count + 1;
		if count = number then return n;
		end if
	end foreach
end function;

create function getgenand (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidand(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from andgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from andgate where gid = n);
		execute function genarateand(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from andgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgenor (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidor(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from orgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from orgate where gid = n);
		execute function genarateor(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from orgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgennot (l int)
	returning int;
	define n int;
	define input1 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidnot(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from notgate where gid = n);
		execute function genaratenot(input1) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from notgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgennand (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidnand(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from nandgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from nandgate where gid = n);
		execute function genaratenand(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from nandgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgennor (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidnor(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from norgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from norgate where gid = n);
		execute function genaratenor(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from norgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgenxor (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidxor(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from xorgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from xorgate where gid = n);
		execute function genaratexor(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from xorgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgenxnor (l int)
	returning int;
	define n int;
	define input1 char;
	define input2 char;
	define output1 char;
	define have int;

	let have = 0;

	foreach
		execute function getgidxnor(l) into n
		select value into input1 from wired where wid = (select getelement(input,1) from xnorgate where gid = n);
		select value into input2 from wired where wid = (select getelement(input,2) from xnorgate where gid = n);
		execute function genaratexnor(input1,input2) into output1;
		update wired set value = output1 where wid = (select getelement(output,1) from xnorgate where gid = n);
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgennew (l int)
	returning int;
	define n int;
	define layout1 int;
	define have int;
	define tempvalue char;
	define tempwid int;
	define tempinput collection;
	define tempoutput collection;
	define count int;
	define tempcount int;

	let have = 0;

	foreach
		execute function getgidnew(l) into n
		select n_layout,input,output  into layout1,tempinput,tempoutput from newgate where gid = n;
		let count = 0;
		foreach
			select * into tempwid from table(tempinput)
			select value into tempvalue from wired where wid = tempwid ;
			let count = count + 1;
			execute function getwidinputorder(count,layout1) into tempwid;
			update wired set value = tempvalue where wid = tempwid;
		end foreach;
		execute function genaratefinal(layout1) into count;
		let count = 0;
		foreach
			execute function getwidoutput(layout1) into tempwid
			select value into tempvalue from wired where wid = tempwid;
			let count = count + 1;
			let tempcount = 0;
			foreach
				select * into tempwid from table(tempoutput)
				let tempcount = tempcount + 1;
				if tempcount = count then
					update wired set value = tempvalue where wid = tempwid;
				end if;
			end foreach;
		end foreach;
		let have = have + 1;
	end foreach
	return have;
end function;

create function getgidand (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from andgate t1 
		where not exists  (select wid  from andgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from andgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidor (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from orgate t1 
		where not exists  (select wid  from orgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from orgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidnot (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from notgate t1 
		where not exists  (select wid  from notgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from notgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidnand (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from nandgate t1 
		where not exists  (select wid  from nandgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from nandgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidnor (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from norgate t1 
		where not exists  (select wid  from norgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from norgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidxor (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from xorgate t1 
		where not exists  (select wid  from xorgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from xorgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidxnor (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from xnorgate t1 
		where not exists  (select wid  from xnorgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from xnorgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidnew (l int)
	returning int;

	define ret int;

	foreach cursor for
		select gid into ret
		from newgate t1 
		where not exists  (select wid  from newgate t2, wired where value is null and wid in input and t2.gid = t1.gid) 
          			and  not exists  (select wid  from newgate t3, wired where value is not null and wid in output and t3.gid = t1.gid)
			and gid in (select gid from layout where lid = l)
		return ret with resume;
	end foreach;
end function;

create function getgidorder (number int,l int)
	returning int;
	define ret int;
	define i int;

	let i = 0;
	foreach
		select gid into ret from layout where lid = l order by 1
		let i = i+1;
		if i = number then return ret;
		end if;
	end foreach;
end function;

create function getnewwid (number int)
	returning int;
	define ret int;
	define count int;

	let count = 0;
	foreach
		select wid into ret from wired where isoutput is null order by 1
		let count = count +1;
		if count = number then return ret;
		end if;
	end foreach;
end function;

create function getnumbergate (l int)
	returning int;
	define ret int;

	select count(*) into ret from layout where lid = l;
	return ret;
end function;

create function getnumberwired (l int)
	returning int;
	define temp int;
	define ret int;

	let ret = 0;
	foreach
		execute function getwid(l) into temp
		let ret = ret + 1;
	end foreach;
	return ret;
end function;

create function getordergid (number int,l int)
	returning int;
	define ret int;
	define i int;

	let i = 0;
	foreach
		select gid into ret from layout where lid = l order by 1
		let i = i+1;
		if ret = number then return i;
		end if;
	end foreach;
end function;

create function getorderwid (number int,l int)
	returning int;
	define ret int;
	define i int;

	let i = 0;
	foreach
		execute function getwid(l) into ret
		let i = i+1;
		if ret = number then return i;
		end if;
	end foreach;
end function;

create function getwid (l int)
	returning int;
	define tempc collection;
	define filter set(int not null);
	define temp int;
	define ret int;

	let filter = "set{}";
	foreach
		select input into tempc from andgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from andgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from orgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from orgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from notgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from notgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from nandgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from nandgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from norgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from norgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from xorgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from xorgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from xnorgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from xnorgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select input into tempc from newgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select output into tempc from newgate where gid in (select gid from layout where lid = l)
		foreach
			select * into temp from table(tempc)
			insert into table(filter) values(temp);
		end foreach;
	end foreach;
	foreach
		select * into ret from table(filter) order by 1
		return ret with resume;
	end foreach;
end function;

create function getwidoutput (l int)
	returning int;
	define ret int;
	define is char;

	foreach
		execute function getwid(l) into ret
		select isoutput into is from wired where wid =ret;
		if is = 'O' then return ret with resume;
		end if;
	end foreach;
end function;

create function getwidinput (l int)
	returning int;
	define ret int;
	define is char;

	foreach
		execute function getwid(l) into ret
		select isoutput into is from wired where wid =ret;
		if is = 'I' then return ret with resume;
		end if;
	end foreach;
end function;

create function getwidoutputorder (number int,l int)
	returning int;
	define ret int;
	define count int;

	let count = 0;
	foreach
		execute function getwidoutput(l) into ret
		let count = count + 1;
		if count = number then return ret;
		end if;
	end foreach;
end function;

create function getwidinputorder (number int,l int)
	returning int;
	define ret int;
	define count int;

	let count = 0;
	foreach
		execute function getwidinput(l) into ret
		let count = count + 1;
		if count = number then return ret;
		end if;
	end foreach;
end function;

create function getwidnumberoutput (l int)
	returning int;
	define ret int;
	define count int;

	let count = 0;
	foreach
		execute function getwidoutput(l) into ret
		let count = count + 1;
	end foreach;
	return count;
end function;

create function getwidnumberinput (l int)
	returning int;
	define ret int;
	define count int;

	let count = 0;
	foreach
		execute function getwidinput(l) into ret
		let count = count + 1;
	end foreach;
	return count;
end function;

create function getwidorder (number int,l int)
	returning int;
	define ret int;
	define i int;

	let i = 0;
	foreach
		execute function getwid(l) into ret
		let i = i+1;
		if i = number then return ret;
		end if;
	end foreach;
end function;

create function getwidvalue (number int,l int)
	returning char;
	define ret int;
	define ret1 char;	

	execute function getwidorder(number,l) into ret;
	select value into ret1 from wired where wid = ret;
	return ret1;
end function;

create function initlayout (number int,l int)
	returning int;
	define ret int;
	define i int;

	select max(gid) into ret from layout;
	if ret is null then let ret = 0;
	end if;
	for i = 1 to number
		insert into layout values(ret+i,null,null,l);
	end for;
end function;

create function initvalue ()
	returning int;

	update wired set value = null;
end function;

create function initwired (number int)
	returning int;
	define ret int;
	define i int;

	select max(wid) into ret from wired;
	if ret is null then let ret = 1000;
	end if;
	for i = 1 to number
		insert into wired values(ret+i,null,null,null);
	end for;
end function;

create function insertvalue (number int,val char,l int)
	returning int;
	define ret int;

	execute function getwidorder(number,l)into ret;
	update wired set value = val where wid = ret;
end function;

create function loadgate(l int)
	returning char(4),int,int;
	define ret int;
	define ret1 int;
	define ret2 int;

	foreach
		select gid into ret from layout where lid = l order by gid
		select gid into ret1 from andgate where gid = ret;
		if ret1 is not null then
		   select cardinality(input),cardinality(output) into ret1,ret2 from andgate where gid = ret;
		   return 'and',ret1,ret2 with resume;
		else
		   select gid into ret1 from orgate where gid = ret;
		   if ret1 is not null then
		      select cardinality(input),cardinality(output) into ret1,ret2 from orgate where gid = ret;
		      return 'or',ret1,ret2 with resume;
		   else
		      select gid into ret1 from notgate where gid = ret;
		      if ret1 is not null then
		         select cardinality(input),cardinality(output) into ret1,ret2 from notgate where gid = ret;
		         return 'not',ret1,ret2 with resume;
		      else
		         select gid into ret1 from nandgate where gid = ret;
		         if ret1 is not null then
		            select cardinality(input),cardinality(output) into ret1,ret2 from nandgate where gid = ret;
		             return 'nand',ret1,ret2 with resume;
		         else
		            select gid into ret1 from norgate where gid = ret;
		            if ret1 is not null then
		               select cardinality(input),cardinality(output) into ret1,ret2 from norgate where gid = ret;
		               return 'nor',ret1,ret2 with resume;
		            else
		               select gid into ret1 from xorgate where gid = ret;
			if ret1 is not null then
			   select cardinality(input),cardinality(output) into ret1,ret2 from xorgate where gid = ret;
			   return 'xor',ret1,ret2 with resume;
			else
			    select gid into ret1 from xnorgate where gid = ret;
			    if ret1 is not null then
			       select cardinality(input),cardinality(output) into ret1,ret2 from xnorgate where gid = ret;
			       return 'xnor',ret1,ret2 with resume;
			    else
			       select cardinality(input),cardinality(output) into ret1,ret2 from newgate where gid = ret;
			       return 'new',ret1,ret2 with resume;
			    end if;
			end if;
		            end if;
		        end if;
		    end if;
		end if;
	            end if;
	end foreach;
end function;

create function loadgatelist (number int,l int)
	returning int;
	define ret int;
	define ret1 collection;
	define ret2 int;

	execute function getwidorder(number,l) into ret;
	select gid into ret1 from wired where wid = ret;
	foreach
		select * into ret2 from table(ret1)
		execute function getordergid(ret2,l) into ret2;
		return ret2 with resume;
	end foreach;
end function;

create function loadinput(number int,l int)
	returning int;
	define ret int;
	define ret1 int;
	define ret2 collection;

	execute function getgidorder(number,l) into ret;
	select gid into ret1 from andgate where gid = ret;
	if ret1 is not null then
		select input into ret2 from andgate where gid = ret;
		foreach
			select * into ret1 from table(ret2)
			execute function getorderwid(ret1,l) into ret1;
			return ret1 with resume;
		end foreach;
	else
		select gid into ret1 from orgate where gid = ret;
		if ret1 is not null then
			select input into ret2 from orgate where gid = ret;
			foreach
				select * into ret1 from table(ret2)
				execute function getorderwid(ret1,l) into ret1;
				return ret1 with resume;
			end foreach;
		else
			select gid into ret1 from notgate where gid = ret;
			if ret1 is not null then
				select input into ret2 from notgate where gid = ret;
				foreach
					select * into ret1 from table(ret2)
					execute function getorderwid(ret1,l) into ret1;
					return ret1 with resume;
				end foreach;
			else
				select gid into ret1 from nandgate where gid = ret;
				if ret1 is not null then
					select input into ret2 from nandgate where gid = ret;
					foreach
						select * into ret1 from table(ret2)
						execute function getorderwid(ret1,l) into ret1;
						return ret1 with resume;
					end foreach;
				else
					select gid into ret1 from norgate where gid = ret;
					if ret1 is not null then
						select input into ret2 from norgate where gid = ret;
						foreach
							select * into ret1 from table(ret2)
							execute function getorderwid(ret1,l) into ret1;
							return ret1 with resume;
						end foreach;
					else
						select gid into ret1 from xorgate where gid = ret;
						if ret1 is not null then
							select input into ret2 from xorgate where gid = ret;
							foreach
								select * into ret1 from table(ret2)
								execute function getorderwid(ret1,l) into ret1;
								return ret1 with resume;
							end foreach;
						else
							select gid into ret1 from xnorgate where gid = ret;
							if ret1 is not null then
								select input into ret2 from xnorgate where gid = ret;
								foreach
									select * into ret1 from table(ret2)
									execute function getorderwid(ret1,l) into ret1;
									return ret1 with resume;
								end foreach;
							else
								select input into ret2 from newgate where gid = ret;
								foreach
									select * into ret1 from table(ret2)
									execute function getorderwid(ret1,l) into ret1;
									return ret1 with resume;
								end foreach;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
end function;

create function loadlink (number int,l int)
	returning int;
	define ret int;

	execute function getgidorder(number,l) into ret;
	select n_layout into ret from newgate where gid = ret;
	return ret;
end function;

create function loadoutput(number int,l int)
	returning int;
	define ret int;
	define ret1 int;
	define ret2 collection;

	execute function getgidorder(number,l) into ret;
	select gid into ret1 from andgate where gid = ret;
	if ret1 is not null then
		select output into ret2 from andgate where gid = ret;
		foreach
			select * into ret1 from table(ret2)
			execute function getorderwid(ret1,l) into ret1;
			return ret1 with resume;
		end foreach;
	else
		select gid into ret1 from orgate where gid = ret;
		if ret1 is not null then
			select output into ret2 from orgate where gid = ret;
			foreach
				select * into ret1 from table(ret2)
				execute function getorderwid(ret1,l) into ret1;
				return ret1 with resume;
			end foreach;
		else
			select gid into ret1 from notgate where gid = ret;
			if ret1 is not null then
				select output into ret2 from notgate where gid = ret;
				foreach
					select * into ret1 from table(ret2)
					execute function getorderwid(ret1,l) into ret1;
					return ret1 with resume;
				end foreach;
			else
				select gid into ret1 from nandgate where gid = ret;
				if ret1 is not null then
					select output into ret2 from nandgate where gid = ret;
					foreach
						select * into ret1 from table(ret2)
						execute function getorderwid(ret1,l) into ret1;
						return ret1 with resume;
					end foreach;
				else
					select gid into ret1 from norgate where gid = ret;
					if ret1 is not null then
						select output into ret2 from norgate where gid = ret;
						foreach
							select * into ret1 from table(ret2)
							execute function getorderwid(ret1,l) into ret1;
							return ret1 with resume;
						end foreach;
					else
						select gid into ret1 from xorgate where gid = ret;
						if ret1 is not null then
							select output into ret2 from xorgate where gid = ret;
							foreach
								select * into ret1 from table(ret2)
								execute function getorderwid(ret1,l) into ret1;
								return ret1 with resume;
							end foreach;
						else
							select gid into ret1 from xnorgate where gid = ret;
							if ret1 is not null then
								select output into ret2 from xnorgate where gid = ret;
								foreach
									select * into ret1 from table(ret2)
									execute function getorderwid(ret1,l) into ret1;
									return ret1 with resume;
								end foreach;
							else
								select output into ret2 from newgate where gid = ret;
								foreach
									select * into ret1 from table(ret2)
									execute function getorderwid(ret1,l) into ret1;
									return ret1 with resume;
								end foreach;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
end function;

create function loadpos(l int)
	returning int,int;
	define ret int;
	define ret1 int;
	define ret2 int;

	foreach
		select gid,pos_x,pos_y into ret,ret1,ret2 from layout where lid = l order by gid
		return ret1,ret2 with resume;
	end foreach;
end function;

create function loadwired (l int)
	returning char,int;
	define ret int;
	define ret1 char;
	define ret2 int;

	foreach
		execute function getwid(l) into ret
		select isoutput,cardinality(gid) into ret1,ret2 from wired where wid = ret;
		return ret1,ret2 with resume;
	end foreach;
end function;

create function makenew (l int)
	returning int;
	define n int;

	update proj_layout set newcomp = 'Y' where lid = l;
end function;
