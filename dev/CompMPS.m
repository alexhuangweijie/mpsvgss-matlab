% CompMPS.m
% A function to
% Oliver Thomson Brown
% 2015-03-04
% 
% [RETURN]
% complexMPS	: cell array, L * 1, contains a random complex matrix product state
%
% [INPUTS]
% HILBY		: int, dimension of the local state space
% L		: int, number of sites in the chain
% COMPRESS	: int, maximum size of on-site matrices, supply 0 returns an exact MPS

function [ complexMPS ] = CompMPS( HILBY, L, COMPRESS )
	if COMPRESS == 0
		COMPRESS = Inf;
	end

	% Return allocation
	complexMPS = cell(L,1);
	% First and last sites
	complexMPS{1} = rand(1, 2, HILBY) + i * rand(1, 2, HILBY);
	complexMPS{L} = rand(2, 1, HILBY) + i * rand(2, 1, HILBY);

	rowSize = 2;
	if L == 3
		colSize = 2;
	else
		colSize = min(4, COMPRESS);
	end

	for site = 2 : 1 : L - 1
		lLen = site + 1;
		rLen = L - site - 1;
		len = min(lLen, rLen);

		complexMPS{site} = rand(rowSize, colSize, HILBY) + i * rand(rowSize, colSize, HILBY);

		rowSize = colSize;
		colSize = min(COMPRESS, 2^len);
	end

	% Normalisation
	complexMPS = MPSNorm(complexMPS);
end