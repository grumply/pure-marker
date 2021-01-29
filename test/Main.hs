{-# language BlockArguments #-}
module Main where

import Pure.Data.Marker
import Pure.Data.Txt

import Pure.Bench 
import Pure.Test

import System.IO

main = do
  hSetBuffering stdout LineBuffering
  
  Pure.Bench.run do
    scope "create marker" do
      (whnfio markIO >>= summary)

    scope "base16" do
      m <- io markIO
      let e = encodeBase16 m 

      scope "encode" do
        whnf encodeBase16 m >>= summary
        
      scope "decode" do
        whnf decodeBase16 e >>= summary


    scope "base62" do
      m <- io markIO
      let e = encodeBase62 m 

      scope "encode" do
        whnf encodeBase62 m >>= summary
        
      scope "decode" do
        whnf decodeBase62 e >>= summary
    

    scope "uuid" do
      m <- io markIO
      let e = encodeUUID m 

      scope "encode" do
        whnf encodeUUID m >>= summary
        
      scope "decode" do
        whnf decodeUUID e >>= summary
    
  Pure.Test.run do
    m1 <- io markIO
    m2 <- io markIO

    scope "sane" do
      scope "base16" do
        expect (decodeBase16 (encodeBase16 m1) == m1)

      scope "base62" do
        expect (decodeBase62 (encodeBase62 m1) == m1)

      scope "uuid" do
        expect (decodeUUID (encodeUUID m1) == m1)

      scope "fromTxt" do
        scope "base16" do
          expect (fromTxt (encodeBase16 m1) == m1)

        scope "base62" do
          expect (fromTxt (encodeBase62 m1) == m1)

        scope "uuid" do
          expect (fromTxt (encodeUUID m1) == m1)
         
    scope "ordered" do
      expect (timestamp m1 <= timestamp m2 && m1 /= m2)
