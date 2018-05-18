*** Settings ***
Documentation    AtMonochromator_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    atMonochromator
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 69 206 253 152 247 194 238 140 56 218 37 23 173 27 106 212 17 216 252 218 195 59 12 0 89 193 142 160 11 12 197 214 79 63 83 200 75 113 233 145 214 79 38 19 18 143 18 119 174 222 158 38 148 230 182 192 163 141 31 73 254 30 103 58 98 84 78 249 226 154 224 233 188 22 23 52 57 145 223 133 147 6 196 56 129 182 193 154 1 12 167 239 118 232 187 101 39 36 227 9 224 53 165 12 241 234 212 38 143 21 190 17 141 58 175 236 76 210 193 111 156 100 204 178 46 97 243 233 249 42 11 45 152 7 220 189 246 242 74 80 32 113 126 252 245 224 140 92 203 76 89 198 241 64 100 129 114 252 216 162 224 245 207 228 144 217 218 186 210 129 9 38 17 130 68 241 11 86 132 186 158 69 51 202 45 220 128 172 38 163 38 143 193 236 202 82 209 73 77 180 20 5 209 225 202 190 150 152 39 122 18 208 51 27 29 75 202 184 95 24 195 14 211 150 186 181 50 157 32 198 181 5 173 30 186 29 60 65 96 250 181 170 99 162 167 37 229 214 166 167 66 90 182 245 208 232 194 10 184 232 197 255 145 154 37 161 199 45 107 245 112 30 18 95 182 186 54 149 134 114 170 52 209 82 85 102 122 238 22 178 75 223 220 0 117 123 136 32 209 80 149 231 129 76 106 221 170 212 42 239 126 234 191 116 153 244 53 170 72 195 216 104 92 63 42 38 84 239 57 12 217 178 15 119 158 218 187 226 119 149 144 225 246 71 20 68 29 243 139 228 233 115 0 160 10 43 228 203 149 207 213 245 186 103 185 48 142 184 82 127 243 172 105 59 82 213 217 137 102 118 23 111 87 235 195 65 105 28 167 57 239 87 192 137 231 122 187 252 13 44 130 151 156 146 67 200 106 9 100 56 44 10 44 190 164 247 3 123 70 210 52 147 127 226 186 146 16 1 42 33 169 226 59 194 145 70 243 136 214 168 122 208 36 44 251 123 67 42 58 50 157 223 230 83 227 111 147 239 6 89 231 47 153 82 118 128 218 232 120 173 166 94 255 98 147 198 123 162 174 193 113 214 63 43 215 56 239 4 169 114 158 179 194 215 66 159 140 155 183 170 14 27 164 67 97 157 161 242 231 191 50 246 139 173 240 29 88 117 129 213 71 173 36 114 148 88 151 20 175 58 30 220 4 238 146 140 141 4 164 71 220 124 82 134 16 65 27 66 36 216 134 217 177 83 225 169 248 124 178 212 28 236 214 206 168 182 44 88 128 31 148 5 156 84 133 114 94 215 89 13 102 24 128 59 220 10 53 185 207 58 204 22 23 204 222 20 110 89 152 67 90 151 238 197 204 16 38 55 200 187 9 186 153 170 245 15 35 249 143 184 128 13 44 191 229 240 66 43 15 207 65 102 124 7 129 240 233 188 7 238 219 136 32 220 156 92 133 231 39 13 39 233 148 46 14 226 180 143 207 230 15 137 32 221 38 0 221 43 144 127 104 161 84 178 240 23 130 27 182 222 0 80 206 98 166 138 214 114 151 82 72 52 117 13 103 28 69 232 87 162 235 87 251 119 19 44 143 29 210 137 135 21 60 169 20 124 192 167 77 254 202 154 130 54 85 55 217 63 37 166 234 50 32 5 50 46 132 85 188 198 220 179 148 141 213 63 125 68 215 180 67 186 87 69 25 142 146 1 240 46 5 82 52 70 155 131 37 157 164 153 74 29 193 166 86 33 147 19 73 223 101 47 217 19 137 4 73 116 170 166 111 50 216 74 128 215 171 192 0 233 226 30 221 50 120 149 64 191 75 143 66 141 85 69 238 76 178 73 255 110 219 162 34 60 196 68 58 128 211 117 34 121 108 208 154 132 168 189 214 158 238 3 102 54 243 180 173 84 106 48 18 214 203 71 251 96 73 202 217 166 196 159 43 32 196 5 177 177 0 66 30 19 67 209 116 30 72 36 2 61 92 184 102 136 230 4 219 89 126 142 173 246 251 83 13 158 125 100 215 61 114 121 210 62 142 206 204 220 28 194 152 199 184 188 121 208 117 66 28 80 27 52 33 197 51 68 248 7 42 242 136 19 56 152 221 107 130 216 56 13 101 168 104 234 127 249 86 105 150 101 159 16 169 50 55 32 224 120 54 26 125 21 49 245 166 133 113 45 255 159 106 173 130 19 186 74 20 223 66 98 237 216 182 82 225 60 49 89 226 128 209 107 131 0 46 13 103 218 162 96 930373664
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] atMonochromator::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
